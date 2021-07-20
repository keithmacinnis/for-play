//
//  User.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-07-19.
//

import Foundation


struct User: Hashable, Codable, Identifiable {
    
    var id: String
    var activities: [String] = []
    var privateActivities: [String] = []
    
    mutating func setId(id: String) {
        self.id = id
    }
    mutating func addActivity(id: String) {
        activities.append(id)
    }
    mutating func addPrivateActivity(id: String) {
        privateActivities.append(id)
    }

    func toAnyObject() -> Any {
      return [
        "id": id,
        "activites": activities,
        "privateActivities": privateActivities
      ]
    }
}
