//
//  For_PlayApp.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-14.
//

import SwiftUI
import Firebase
import MapKit

@main
struct For_PlayApp: App {
    @StateObject private var modelData = ModelData()
    @StateObject private var activityData = ActivitiesViewModel()
    @StateObject private var user = User()

    init() {
        FirebaseApp.configure()
        UITextView.appearance().backgroundColor = .clear
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(activityData)
                .environmentObject(user)
        }
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}

let gradient = AngularGradient(
    gradient: Gradient(colors: [.green, .blue]),
    center: .center,
    startAngle: .degrees(0),
    endAngle: .degrees(360))

enum LoginViewState {
    case showContent
    case showLogin
    case showSignup
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Whisitler"
        annotation.subtitle = "Home to the 2010 Winter Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude:  -50.154164 , longitude: -122.96390)
        return annotation
    }
}

//extension Map {
//    func mapViewDidChangeVisibleRegion(_ mapView: Map) {
//        mapView.onTapGesture {
//            mapView.
//        }}
//}
//
//    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//    ////            if !mapView.showsUserLocation {
//        mapView.userTrackingMode = MKUserTrackingMode.none
//        print("Tracking now off")
//    //            //  /   }
//            }
//}

//        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
////            if !mapView.showsUserLocation {
//                print("updating center cord")
//                parent.centerCoordinate = mapView.centerCoordinate
//            //  /   }
//        }
