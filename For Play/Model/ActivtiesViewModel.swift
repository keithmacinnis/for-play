//
//  ActivtiesViewModel.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import Foundation
import Firebase
import Combine

class ActivitiesViewModel: ObservableObject {
    private var ref = Database.database().reference(withPath: "Activties")
    @Published var activities: [Activity] = []
    
    func getAutoUIDforActivities() -> String {
        return ref.childByAutoId().key!
    }
    
    func fetchActivties() {
        ref.observe(DataEventType.value, with:  { snapshot in
            let data = snapshot.value as? [String : AnyObject] ?? [:]
            self.activities = data.map { (activity) -> Activity in
                let title = activity.value["title"] as! String
                let id = activity.value["id"] as! String
                let authorsUID = activity.value["authorsUID"]  as! String
              return Activity(id: id, title: title, authorUID: authorsUID)
            }
        })
    }
    
    func postActivity(activity: Activity) {
        ref.child(activity.id).setValue(activity.toAnyObject()) { (err, ref) in
            if let error = err {
                print("Error during save: \(error.localizedDescription)")
            } else {
                print("activity saved \(ref.description())")
            }
        }
    }
}
