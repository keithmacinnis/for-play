//
//  LocationFetcher.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-24.
//

import CoreLocation
import MapKit

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
        
    }
    
    func start() {
//        let status = CLLocationManager.authorizationStatus()
//        switch status {
//            case .authorizedAlways:
//                print(status)
//            case .authorizedWhenInUse:
//                print(status)
//            case .denied:
//                print(status)
//            case .notDetermined:
//                print(status)
//            case .restricted:
//                print(status)
//        default:
//            print("LocationFetcher.swift: unknown \(status)")
//        }
        // Handle each case of location permissions
        
        manager.requestWhenInUseAuthorization()
        //manager.startUpdatingLocation()
        manager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
               
        lastKnownLocation = locations.first?.coordinate
    }
}
