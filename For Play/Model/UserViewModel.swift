//
//  User.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-15.
//

import Combine
import Foundation
import FirebaseAuth
import MapKit
import Firebase

final class UserViewModel: ObservableObject {
    //Store location ni homelocation to make fetching local lazyier
    @Published var loginState: LoginViewState = Auth.auth().currentUser !=  nil ? .showContent : .showLogin
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
      handle = Auth.auth().addStateDidChangeListener { (auth,user) in
            if user != nil {
                self.loginState = .showContent
            } else {
                print("User is nil (from user.swift)")
                self.loginState = .showLogin
            }
        }
        whereAmI.start()
    }
//    func getMeta(_ uid : String) {
//        //TODO Implement observeMeta to reduce bandwidth
//        let ref = Database.database().reference().child("users").child(uid)
//        ref.getData { (error, snapshot) in
//            if let error = error {
//                print("Error getting data \(error)")
//            }
//            else if snapshot.exists() {
//                print("Got data \(snapshot.value!)")
//            }
//            else {
//                print("No data available")
//            }
//        }
//    }
    
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
    func getUID ()-> String {
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
                //print("In UserViewModel.PasswordResetRequest(): \(errorMessage)")
                onError(errorMessage)
            } else {
                //print("success")
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
    func register(_ email: String,_ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                print(result ?? "success")
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
     
        
}

