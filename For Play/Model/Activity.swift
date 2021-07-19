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
    var password: String?
    
//    init( id: String, title: String, authorUID: String){
//        self.id = id
//        self.title = title
//        self.authorsUID = authorUID
//        self.members = [authorUID]
//    }
//    init(activity: Activity) {
//        self = activity
//    }
//    init(activity: Activity, newId: String) {
//        self = activity
//        self.setId(id: newId)
//    }
//    init(id: String, title: String, authorUID: String, members: [String], date: Date, coordinates: Coordinates){
//        self.id = id
//        self.title = title
//        self.authorsUID = authorUID
//        self.members = members
//        self.date = date
//        self.coordinates = coordinates
//    }
    func getLocation() -> MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: coordinates!.latitude, longitude: coordinates!.longitude)
        return MKCoordinateRegion(center: center, latitudinalMeters: 420, longitudinalMeters: 420)
    }
    func getPlacemark() -> MKPlacemark {
        return MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: coordinates!.latitude, longitude: coordinates!.longitude))
    }
    func openMeInNativeMapApp() {
        let mapItem = MKMapItem(placemark: getPlacemark())
        mapItem.openInMaps(launchOptions: nil)
    }
    mutating func setId(id: String) {
        self.id = id
    }
    mutating func addMemeber(id: String) {
        members.append(id)
    }

    func toAnyObject() -> Any {
      return [
        "id": id,
        "title": title,
        "authorsUID": authorsUID,
        "members": members,
        "date": date ?? "",
        "coordinates": coordinates ?? "",
        "password": password ?? ""
      ]
    }
}
