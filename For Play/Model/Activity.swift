//
//  Activity.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-14.
//

import Foundation
import SwiftUI
import CoreLocation

struct Activity: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var authorsUsername: String
    var isPrivate: Bool
    var locality: String
    var subAdministrativeArea: String
    var administrativeArea: String
    var country: String
    var parkOrVenue: String? = nil
    var activityType: String
    var description: String
    var members: [String]
    var hashTags: [String]
    var password: String? = nil

//    var category: Category
//    enum Category: String, CaseIterable, Codable {
//        case lakes = "Lakes"
//        case rivers = "Rivers"
//        case mountains = "Mountains"
//    }
//    private var imageName: String
//    var image: Image {
//        Image(imageName)
//
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
