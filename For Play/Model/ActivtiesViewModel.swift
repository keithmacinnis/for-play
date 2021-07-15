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

final class ActivitiesViewModel: ObservableObject {
    var db: Firestore
    @Published var activities: [Activity] = []
    
    init() {
        print("ActivitiesViewModel.swift init called")
        db = Firestore.firestore()
        fetchActivties()
    }
    func getUniqueIDforActivity() -> String {
        return db.collection("activities").document().documentID
    }
    func findUsersActivties(userID: String) -> [Activity] {
        return activities.filter { activity in
            activity.members.contains(userID)
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
            } ?? []
            print(self.activities)
        }
    }
    func postActivity(title: String, authorUID: String, date: Date, user: UserViewModel) {
        let ref = db.collection("activities").document()
        let activity = Activity(id: ref.documentID, title: title, authorUID: authorUID, members: [authorUID], date: date)
        do {
            try ref.setData(from: activity)
        } catch let error {
            print("Error writing activity to Firestore: \(error)")
        }
        user.addActivity(activityID: ref.documentID)
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
}
