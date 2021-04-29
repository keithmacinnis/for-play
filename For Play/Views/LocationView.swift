////
////  LocationView.swift
////  For Play
////
////  Created by Keith MacInnis on 2021-04-24.
////
//
//import SwiftUI
//import MapKit
//
//fileprivate let locationFetcher = LocationFetcher()
//
//struct LocationView: View {
//    
//    @State var centerCoordinate = CLLocationCoordinate2D()
//    @State var currentLocation: CLLocationCoordinate2D?
//    @Binding var annotation: MKPointAnnotation
//    @Binding var placemark: String
//    @Binding var isActive: Bool
//    
//    var body: some View {
//        ZStack {
//            MapView(centerCoordinate: $centerCoordinate, currentLocation: currentLocation, withAnnotation: annotation)
//                .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
//                .onAppear(perform: {
//                    locationFetcher.start()
//                })
//                Circle()
//                    .fill(Color.blue)
//                    .opacity(0.3)
//                    .frame(width: 16, height: 16)
//            HStack {
//                Spacer()
//                VStack {
//                    Spacer()
//                    VStack(){
//                        ZoomToUsersLocatonButton(self)
//                        Button(action: {
//                            let location = MKPointAnnotation()
//                            location.coordinate = centerCoordinate
//                            annotation = location
//                            let place = MKPlacemark(coordinate: centerCoordinate)
//                            placemark = "\(place.country), \(place.locality)"
//                            isActive = false
//                        }) {
//                            Image(systemName: "plus")
//                                .padding()
//                                .background(Color.black.opacity(0.75))
//                                .foregroundColor(.white)
//                                .font(.title)
//                                .clipShape(Circle())
//                        }
//                        //AddButton(self)
////                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
////                            Image(systemName: "arrow.down.circle.fill")
////                                .padding()
////                                .background(Color.red.opacity(0.75))
////                                .foregroundColor(.white)
////                                .font(.title)
////                                .clipShape(Circle())
////                        })
//                    }
//            }
//            .padding()
//
//            }}
//    }
////    struct AddButton: View {
////
////        var parent: LocationView
////
////        init(_ parent: LocationView) {
////            self.parent = parent
////        }
////
////        var body: some View {
////            VStack {
////                HStack {
////
////                    Button(action: {
////                        let location = MKPointAnnotation()
////                        location.coordinate = parent.centerCoordinate
////                        parent.annotation = location
////                        parent.isActive = false
////                    }) {
////                        Image(systemName: "plus")
////                            .padding()
////                            .background(Color.black.opacity(0.75))
////                            .foregroundColor(.white)
////                            .font(.title)
////                            .clipShape(Circle())
////                    }
////                }
////            }
////        }
////    }
//
//    struct ZoomToUsersLocatonButton: View {
//        
//        var parent: LocationView
//        
//        init(_ parent: LocationView) {
//            self.parent = parent
//        }
//        
//        var body: some View {
//            VStack {
//                HStack {
//                    Button(action: {
//                        if let location = locationFetcher.lastKnownLocation {
//                            print("Your location is \(location)")
//                            parent.currentLocation = location
//                        } else {
//                            print("Your location is unknown")
//                        }
//                    }
//                    ) {
//                        Image(systemName: "location.circle.fill")
//                            .padding()
//                            .background(Color.blue.opacity(0.75))
//                            .foregroundColor(.white)
//                            .font(.title)
//                            .clipShape(Circle())
//                            .rotationEffect(.degrees(45))
//                    }
//                }
//            }
//        }
//    }
//}
//
////struct LocationView_Previews: PreviewProvider {
////    static var previews: some View {
////        LocationView(isActive: .constant(false), annotation: <#Binding<MKPointAnnotation>#>)
////    }
////}
