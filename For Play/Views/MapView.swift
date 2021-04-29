////
////  MapView.swift
////  For Play
////
////  Created by Keith MacInnis on 2021-04-24.
////
//
import SwiftUI
import MapKit

struct MapView  : UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    var annotations: [MKPointAnnotation]
    
  
    func makeUIView(context: Context) -> MKMapView {
            let mapView = MKMapView()
            mapView.delegate = context.coordinator
            mapView.showsUserLocation = false
            return mapView
        }

    func updateUIView(_ view: MKMapView, context: Context) {
        if view.showsUserLocation == false {
            view.showsUserLocation = true
            view.setRegion(MKCoordinateRegion(center: view.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)), animated: true)
        }
        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
    }

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        class Coordinator: NSObject, MKMapViewDelegate {
            var parent: MapView
            

            init(_ parent: MapView) {
                self.parent = parent
            }
//          the  mapViewDidChangeVisibleRegion() method in our map view’s coordinator wilil kick off that whole chain. Map->Cordiniator->view
            func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
                print("mapViewDidChangeVisibleRegion: \(mapView.centerCoordinate)")
                parent.centerCoordinate = mapView.centerCoordinate
            }
        }
    
}
//    var currentLocation: CLLocationCoordinate2D?
//
//    var withAnnotation: MKPointAnnotation?
//    var bounds: MKMapRect?
//    
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//
//        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
////            if !mapView.showsUserLocation {
//                print("updating center cord")
//                parent.centerCoordinate = mapView.centerCoordinate
//            //  /   }
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        mapView.mapType = .hybridFlyover
//        mapView.isPitchEnabled = true
//        mapView.showsUserLocation = true
//        mapView.showsCompass = true
//        mapView.setCenter(currentLocation ?? centerCoordinate, animated: false)
//        mapView.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 10000), animated: false)
//        return mapView
//    }
//
//    func updateUIView(_ view: MKMapView, context: Context) {
//        print("in update view //////..")
//
//       // let northeast = CLLocationCoordinate2D(latitude: centerCoordinate.latitude - 1, longitude: centerCoordinate.longitude - 1)
//       // let southwest = CLLocationCoordinate2D(latitude: centerCoordinate.latitude + 1, longitude: centerCoordinate.longitude + 1)
//
////        if let currentLocation = self.currentLocation {
////            if let annotation = self.withAnnotation {
////                view.removeAnnotation(annotation)
////            }
////            view.showsUserLocation = true
////            let region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
////            view.setRegion(region, animated: true)
////        } else if let annotation = self.withAnnotation {
////            view.removeAnnotations(view.annotations)
////            view.addAnnotation(annotation)
////        }
//
//    }
//}
//
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView( centerCoordinate: .constant(MKPointAnnotation.example.coordinate))    }
//}
