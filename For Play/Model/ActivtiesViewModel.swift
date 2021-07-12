//
//  ActivtiesViewModel.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import Foundation
import Firebase
import Combine
import FirebaseFirestoreSwift


final class ActivitiesViewModel: ObservableObject {
    var db: Firestore
    @Published var activities: [Activity] = []
    
    init() {
        print("ActivitiesViewModel.swift init called")
        db = Firestore.firestore()
        fetchActivties()
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
    //Called when a user hits Post Activity
    func postActivity(activity: Activity) {
        print("postActivity")
        do {
            try db.collection("activities").addDocument(from: activity)
        } catch let error {
            print("Error writing activity to Firestore: \(error)")
        }
    }
    //Called when a user hits Join Activity
    func updateActivity(activityUID: String, userUID: String) {
        let ref = db.collection("activities").document(activityUID)
        ref.updateData([
            "members": FieldValue.arrayUnion([userUID])
        ])
    }
}
