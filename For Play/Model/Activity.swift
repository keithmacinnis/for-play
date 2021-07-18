//
//  Activity.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-14.
//

import Foundation
import CoreLocation
import MapKit

struct Activity: Hashable, Codable, Identifiable {
    
    var id: String
    var title: String
    var authorsUID: String
    var members: [String]
    var date: Date?
    var coordinates: Coordinates?
    
    init( id: String, title: String, authorUID: String){
        self.id = id
        self.title = title
        self.authorsUID = authorUID
        self.members = [authorUID]
    }
    init(activity: Activity) {
        self = activity
    }
    func getLocation() -> MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: coordinates!.latitude, longitude: coordinates!.longitude)
        return MKCoordinateRegion(center: center, latitudinalMeters: 420, longitudinalMeters: 420)
    }
    init(activity: Activity, newId: String) {
        self = activity
        self.setId(id: newId)
    }
    init(id: String, title: String, authorUID: String, members: [String], date: Date, coordinates: Coordinates){
        self.id = id
        self.title = title
        self.authorsUID = authorUID
        self.members = members
        self.date = date
        self.coordinates = coordinates
    }
    mutating func setId(id: String) {
        self.id = id
    }
    mutating func addMemeber(id: String) {
        members.append(id)
    }
//    var isPrivate: Bool?
//    var locality: String?
//    var subAdministrativeArea: String?
//    var administrativeArea: String?
//    var country: String?
//    var activityType: String?
//    var description: String?
//    var members: [String]?
//    var hashTags: [String]?
//    var password: String? = nil

    func toAnyObject() -> Any {
      return [
        "id": id,
        "title": title,
        "authorsUID": authorsUID,
        "members": members
      ]
    }
//    private var coordinates: Coordinates
//    var locationCoordinate: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(
//            latitude: coordinates.latitude,
//            longitude: coordinates.longitude)
//    }
//    struct Coordinates: Hashable, Codable {
//        var latitude: Double
//        var longitude: Double
//    }
}
