////
////  MapView.swift
////  For Play
////
////  Created by Keith MacInnis on 2021-04-24.
////
//
import SwiftUI
import MapKit

struct ForPlay_MapView : View {
    
    @EnvironmentObject var user: UserViewModel
    @Binding var region: MKCoordinateRegion
    @Binding var userTracking: MapUserTrackingMode
    @Binding var locations: [MKPointAnnotation]
    @Binding var eventLocation: String
    @Binding var cordsOfEvent: Coordinates
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $region, interactionModes: [MapInteractionModes.all], showsUserLocation: true, userTrackingMode: $userTracking)
                .frame( height: 386)
                .frame(height: 256)
                .cornerRadius(25.0)
                .shadow(radius: 10.0, x: 20, y: 10)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 16, height: 16)
            Circle()
                .fill(Color.black)
                .opacity(0.3)
                .frame(width: 1, height: 1)
            HStack {
                Spacer()
                VStack {
                Spacer()
                HStack(){
                    VStack(){
                        Button(action: {zoom()}) {Image(systemName: "location.circle.fill")
                            .background(Color.blue.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .rotationEffect(.degrees(30))
                        }
                    }
                    VStack(){
                        Button(action: {saveCrosshairLocation()}) {
                        Image(systemName: "checkmark.circle.fill")
                            .background(Color.blue.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                        }
                    }}}
                }
            }
    }
    func saveCrosshairLocation() {
            let newLocation = MKPointAnnotation()
            newLocation.coordinate = self.region.center
            self.locations.append(newLocation)
            let local: CLLocation = CLLocation(latitude: self.region.center.latitude , longitude: self.region.center.longitude)
            cordsOfEvent = Coordinates(latitude: self.region.center.latitude , longitude: self.region.center.longitude)
            CLGeocoder().reverseGeocodeLocation(local) { (placemarks, error) in
                guard error == nil else {
                    print("ReverseGeocode Error: \(String(describing: error))")
                    return
                }
                if let firstPlacemark = placemarks?.first {
                    print(firstPlacemark)
                    var addressString : String = ""
                    if firstPlacemark.name != nil {
                        addressString = addressString + firstPlacemark.name! + ", "
                    }else {
                        if firstPlacemark.subThoroughfare != nil {
                            addressString = addressString + firstPlacemark.subThoroughfare! + ", "
                        }
                        if firstPlacemark.thoroughfare != nil {
                            addressString = addressString + firstPlacemark.thoroughfare! + ", "
                        }
                    }
                    if firstPlacemark.subLocality != nil {
                        addressString = addressString + firstPlacemark.subLocality! + ", "
                    }
                    if firstPlacemark.locality != nil {
                        addressString = addressString + firstPlacemark.locality! + ", "
                    }
                    if firstPlacemark.country != nil {
                        addressString = addressString + firstPlacemark.country! + ", "
                    }
                    if firstPlacemark.postalCode != nil {
                        addressString = addressString + firstPlacemark.postalCode! + ", "
                    }
                    if firstPlacemark.region != nil {
                        addressString = addressString + "<\(local.coordinate.latitude),\(local.coordinate.longitude)>"
                    }
                    self.eventLocation = addressString
                }
            }
        }
    func zoom() {
        let newZoom = 0.08
        self.region = MKCoordinateRegion(center: user.getLocation(), span:  MKCoordinateSpan(latitudeDelta: newZoom, longitudeDelta: newZoom))
    }
}
