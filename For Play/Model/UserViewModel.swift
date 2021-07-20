//
//  User.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-15.
//
import MapKit
import Combine
import StreamChat
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

//Works with both the firebase Auth and our custom User
final class UserViewModel: ObservableObject {
    //Store location ni homelocation to make fetching local lazyier
    @Published var loginState: LoginViewState = Auth.auth().currentUser !=  nil ? .showContent : .showLogin
    @Published var activities: [Activity] = []
    @Published var user: User?
    var db: Firestore
    var uid: String?
    var email: String?
    var username: String?
    var password: String?
    var handle: AuthStateDidChangeListenerHandle?
    var location: CLLocationCoordinate2D?
    var homeLocation: CLLocationCoordinate2D?
    private let whereAmI =  LocationFetcher()
    
    init() {
        print("UserViewModel.swift init called for \(String(describing: uid))")
        db = Firestore.firestore()
        handle = Auth.auth().addStateDidChangeListener { (auth,user) in
            if user != nil {
                self.loginState = .showContent
                self.user = User(id: user!.uid)
                self.configureChatClient()
            } else {
                print("User is nil (from user.swift)")
                self.loginState = .showLogin
                self.user = nil
                self.cleanupAfterLogout()
            }
        }
        whereAmI.start()
    }
    func configureChatClient() {
        ChatClient.shared.tokenProvider = .development(userId: getUID())
        ChatClient.shared.currentUserController().reloadUserIfNeeded()
    }
    func fetchActivties(avm: ActivitiesViewModel) {
        fetchUser()
        activities = avm.findUsersActivties(userID: uid ?? getUID())
        for activityID in user!.privateActivities {
            let activity = avm.fetchAcitvity(id: activityID, table: "privateActivities")
            print("step 2")
            if activity != nil {
                activities.append(activity!)
            }
        }
    }
    func fetchUser() {
        let ref = db.collection("users").document(getUID())
        ref.getDocument { document, error in
            let result = Result {
              try document?.data(as: User.self)
            }
            switch result {
              case .success(let user):
                  if let user = user {
                      // A `User` value was successfully initialized from the DocumentSnapshot.
                      print("User: \(user)")
                      self.user = user
                  } else {
                      // A nil value was successfully initialized from the DocumentSnapshot, or the DocumentSnapshot was nil.
                      print("Document does not exist")
                  }
              case .failure(let error):
                  // A `user` value could not be initialized from the DocumentSnapshot.
                  print("Error decoding user: \(error)")
              }
        }
    }
    func addSelf(){
        let uid = getUID()
        let ref = db.collection("users").document(uid)
        ref.setData([
            "id": uid
        ])
    }
    func addActivity(activityID: String){
        let uid = getUID()
        let ref = db.collection("users").document(uid)
        ref.updateData([
            "activities": FieldValue.arrayUnion([activityID])
        ])
    }
    func addPrivateActivity(activityID: String){
        let uid = getUID()
        let ref = db.collection("users").document(uid)
        ref.updateData([
            "privateActivities": FieldValue.arrayUnion([activityID])
        ])
    }
    func removeActivity(activityID: String){
        let uid = getUID()
        let ref = db.collection("users").document(uid)
        ref.updateData([
            "activities": FieldValue.arrayRemove([activityID])
        ])
    }
    func removePrivateActivity(activityID: String){
        let uid = getUID()
        let ref = db.collection("users").document(uid)
        ref.updateData([
            "privateActivities": FieldValue.arrayRemove([activityID])
        ])
    }
    
    func getLocation() -> MKCoordinateRegion {
        if let location = whereAmI.lastKnownLocation {
            print("Your location is \(location)")
            self.location = location
            return MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        } else {
            print("Your location is unknown \(location)")
            return MKCoordinateRegion()
        }
    }
    
    func getLocation() -> CLLocationCoordinate2D {
        if let location = whereAmI.lastKnownLocation {
            print("Your location is \(location)")
            self.location = location
            return location
        } else {
            print("Your location is unknown")
            return CLLocationCoordinate2D()
        }
    }
    func getUID() -> String {
        if self.uid == nil {
            self.uid = Auth.auth().currentUser?.uid
        }
        return  self.uid ?? "error"
    }
    func getEmail ()-> String {
        if self.email == nil {
            self.email = Auth.auth().currentUser?.email
        }
        return  self.email ?? "error"
    }
    func passwordResetRequest(_ email: String,
                              onSuccess: @escaping() -> Void,
                              onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                let errorMessage = error?.localizedDescription ?? "unknown error"
                onError(errorMessage)
            } else {
                onSuccess()
            }
        }
    }
    func login(_ email: String,_ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                print(result ?? "success")
            }
        }
    }
    //Add user to auth on firebase auth, as well as users on firestorm
    func register(_ email: String,_ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                print(result ?? "success")
                self.addSelf()
            }
        }
    }
    func logout() {
        let firebaseAuth = Auth.auth()
           do {
                 try firebaseAuth.signOut()
               } catch let signOutError as NSError {
                 print ("Error signing out: %@", signOutError)
               }
    }
    
    func cleanupAfterLogout() {
        print("TODO CLEANUP after logout")
    }
}
