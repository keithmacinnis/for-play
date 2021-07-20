//
//  ActivtiesViewModel.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import Combine
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import StreamChat

final class ActivitiesViewModel: ObservableObject {
    var db: Firestore
    @Published var activities: [Activity] = []
    @Published var filteredActivities: [Activity] = []
    
    init() {
        print("ActivitiesViewModel.swift init called")
        db = Firestore.firestore()
        fetchActivties()
    }
    func getUniqueIDforActivity() -> String {
        return db.collection("activities").document().documentID
    }
    func activtiesThisUserIsntIn(userID: String) -> [Activity] {
        return activities.filter { activity in
            if (activity.members.contains(userID)) {
                return false
            }else {
                return true
            }
        }
    }
    func refreshFilteredActivtivties(userID: String) {
        filteredActivities = activtiesThisUserIsntIn(userID: userID)
    }
    func findUsersActivties(userID: String) -> [Activity] {
        return activities.filter { activity in
            activity.members.contains(userID)
        }
    }
    //Takes an activties uid, and the table to search (privateActivities or Activties usually),
    //and then a function to handle the return value of that Activity.
    func fetchAcitvity(id : String, table: String, completion:@escaping (Activity) -> Void) {
        let ref = db.collection(table).document(id)
        ref.getDocument { document, error in
            let result = Result {
              try document?.data(as: Activity.self)
            }
            switch result {
              case .success(let activity):
                  if let activity = activity {
                        // A `activity` value was successfully initialized from the DocumentSnapshot.
                        print("Activity: \(activity)")
                        completion(activity)
                  } else {
                      // A nil value was successfully initialized from the DocumentSnapshot, or the DocumentSnapshot was nil.
                      print("Document does not exist")
                  }
              case .failure(let error):
                  // A `activity` value could not be initialized from the DocumentSnapshot.
                  print("Error decoding user: \(error)")
              }
        }
    }
    func fetchActivties() {
        db.collection("activities").addSnapshotListener {  snapshot, error    in
            guard let activityDocuments = snapshot?.documents else {
                print ("Error fetching: \(error)")
                return
            }
            self.activities = activityDocuments.compactMap { activity in
               try? activity.data(as: Activity.self)
            }
        }
    }
    func postActivity(title: String, authorUID: String, date: Date, user: UserViewModel, cordsOfEvent: Coordinates, isPrivate: Bool, password: String) {
        //Private Events and Public Events have unqie tables
        var db_table = "activities"
        if isPrivate { db_table = "privateActivities" }
        let ref = db.collection(db_table).document()
        let activity = Activity(id: ref.documentID, title: title, authorsUID: authorUID, members: [authorUID], date: date, coordinates: cordsOfEvent, password: password)
        do {
            try ref.setData(from: activity)
        } catch let error {
            print("Error writing activity to Firestore: \(error)")
        }
        if isPrivate {
            user.addPrivateActivity(activityID: ref.documentID)
        } else {
            user.addActivity(activityID: ref.documentID)
        }
    }
    func updateActivityByRemoval(activityUID: String, userUID: String, user: UserViewModel) {
        db.collection("activities").document(activityUID).updateData([
            "members": FieldValue.arrayRemove([userUID])
        ])
        user.removeActivity(activityID: activityUID)
    }
    //There are two locations to update; users table and actitivties table.
    func updateActivity(activityUID: String, userUID: String, user: UserViewModel) {
        db.collection("activities").document(activityUID).updateData([
            "members": FieldValue.arrayUnion([userUID])
        ])
        user.addActivity(activityID: activityUID)
    }
    //joins a private activity
    func validatePasswordTitlePair (title: String, password: String, user: UserViewModel) {
        db.collection("privateActivities").whereField("title", isEqualTo: title).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting private documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        let activity = try document.data(as: Activity.self)
                        //print("\(document.documentID) => \(document.data())")
                        print("supplied password \(password) and events pw: \(activity!.password!)")
                        if password == activity!.password! {
                            self.updateHiddenActivity(activityUID: activity!.id, userUID: user.getUID(), user: user)
                        }
                    } catch {
                        print("//couldn't craete activity type")
                    }
                }
            }
        }
    }
    func updateHiddenActivity(activityUID: String, userUID: String, user: UserViewModel) {
        db.collection("privateActivities").document(activityUID).updateData([
            "members": FieldValue.arrayUnion([userUID])
        ])
        user.addPrivateActivity(activityID: activityUID)
    }
    
    func getActivityChatChannel(channelName : String) -> ChatChannelController.ObservableObject {
        return ChatClient.shared.channelController(
                for: ChannelId(
                    type: .messaging,
                    id:  channelName
                )
            ).observableObject
    }
}
