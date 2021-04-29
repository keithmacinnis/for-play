//
//  PostActivityView.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI
import MapKit

struct PostActivityView: View {
    @EnvironmentObject var viewModel: ActivitiesViewModel
    @EnvironmentObject var user: User
    
    @State var region: MKCoordinateRegion  //MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: MKPointAnnotation.example.coordinate.latitude, longitude: MKPointAnnotation.example.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
    @State var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var userTracking = MapUserTrackingMode.follow
    @State private var eventTitle = ""
    @State private var eventPassword = ""
    @State private var eventActivity = ""
    @State private var eventLocation = ""
    @State private var hashTags = ""
    @State private var date = Date()
    @State private var isPrivate = false
    @State private var longDescription: String = "Description"
    @State private var longDescTapped = false
    @State private var scrollTarget: Int?
    
    let dateRange: ClosedRange<Date> = {
        let now = Date()
        let currentMinuteTime = Calendar.current.component(.minute, from: now)
        let startingTime = Calendar.current.date(byAdding: .minute, value: 1440 + (60-currentMinuteTime), to: now)
        //let components =
        let endingTime = Calendar.current.date(byAdding: .month, value: 6, to: now)
        return startingTime! ... endingTime!
    }()
    
//    init() {
//        print("PostActivityView init called")
//    }
    var body: some View {
    ScrollViewReader { scrollView in
        ScrollView {
            VStack() {
                Image(systemName: "figure.walk.diamond")
                    .resizable()
                    .foregroundColor(Color.yellow)
                    .frame(width: 175, height: 175)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(gradient, lineWidth: 4))
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding([.bottom],20)
                Spacer()
                VStack(alignment: .leading, spacing: 15) {
                    DatePicker(
                        "Time & Date:",
                         selection: $date,
                         in: dateRange,
                         displayedComponents: [.date, .hourAndMinute]
                        
                    )
                    .frame(height: 42.3)
                    .accentColor(.black)
                    .foregroundColor(Color.black)
                    
                    Toggle(isOn: $isPrivate, label: {
                        Text("Private")
                            .foregroundColor(Color.black)
                    })
                    TextField("Event Title", text: self.$eventTitle)
                        .padding()
                        .background(Color.themeTextField)
                        .foregroundColor(.black)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    if isPrivate  {
                    SecureField("Password", text: self.$eventPassword)
                        .padding()
                        .background(Color.themeTextField)
                        .foregroundColor(.black)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    }
                    TextField("Activity", text: self.$eventActivity)
                        .padding()
                        .background(Color.themeTextField)
                        .foregroundColor(.black)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    TextField("Location", text: self.$eventLocation)
                        .padding()
                        .background(Color.themeTextField)
                        .foregroundColor(.black)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    ZStack{
                    //MapView(centerCoordinate: $centerCoordinate)
//
                      
                    Map(coordinateRegion: $region, interactionModes: [MapInteractionModes.all], showsUserLocation: true, userTrackingMode: $userTracking)
                        //Map(coordinateRegion: $region, showsUserLocation: true , userTrackingMode: $userTracking)
//                    MapView(centerCoordinate: $centerCoordinate, annotations: locations)
                        .frame( height: 386)
                        .frame(height: 256)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    Circle()
                        .fill(Color.blue)
                        .opacity(0.3)
                        .frame(width: 16, height: 16)
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            VStack(){
                                //SAVE LOCATION BUTTON
                                Button(action: {
                                    let newLocation = MKPointAnnotation()
                                    newLocation.coordinate = self.region.center
                                    self.locations.append(newLocation)
                                    let local: CLLocation = CLLocation(latitude: self.region.center.latitude , longitude: self.region.center.longitude)
                                    CLGeocoder().reverseGeocodeLocation(local) { (placemarks, error) in
                                        guard error == nil else {
                                            print("ReverseGeocode Error: \(error)")
                                            return
                                        }
                                        // Most geocoding requests contain only one result.
                                        if let firstPlacemark = placemarks?.first {
                                            //self.mostRecentPlacemark = firstPlacemark
                                            print(firstPlacemark)
                                            var addressString : String = ""
                                            if firstPlacemark.subLocality != nil {
                                                addressString = addressString + firstPlacemark.subLocality! + ", "
                                            }
                                            if firstPlacemark.subThoroughfare != nil {
                                                addressString = addressString + firstPlacemark.thoroughfare! + ", "
                                            }
                                            if firstPlacemark.subThoroughfare != nil {
                                                addressString = addressString + firstPlacemark.subThoroughfare! + ", "
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
                                            //self.eventLocation = "\(firstPlacemark.addressDictionary![1]), \(firstPlacemark.addressDictionary![2]), \(firstPlacemark.addressDictionary![3])"
                                           // self.eventLocation = "\(firstPlacemark.subLocality!), \(firstPlacemark.subThoroughfare!) \(firstPlacemark.thoroughfare!)"
                                            
                                        }
                                    }
                                }) {Image(systemName: "checkmark.circle.fill")
                                    .background(Color.blue.opacity(0.75))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .clipShape(Circle())
                                }
                            }
                            VStack(){
                                //ZOOM TO LOCATION BUTTON
                                Button(action: {
                                    self.region.center = user.getLocation()
                                    let newZoom = 0.08 //region.span.latitudeDelta * 0.42
                                    self.region.span = MKCoordinateSpan(latitudeDelta: newZoom, longitudeDelta: newZoom)
                                    
//                                    if let location = locationFetcher.lastKnownLocation {
//                                        print("Your location is \(location), your cewnter cord is \(self.region)")
//                                        self.centerCoordinate = location
//                                        let local: CLLocation = CLLocation(latitude: location.latitude , longitude: location.longitude)
//                                        CLGeocoder().reverseGeocodeLocation(local) { (placemarks, error) in
//                                                        guard error == nil else {
//                                                            print(error)
//                                                            return
//                                                        }
//                                                        // Most geocoding requests contain only one result.
//                                                        if let firstPlacemark = placemarks?.first {
//                                                            //self.mostRecentPlacemark = firstPlacemark
//                                                            self.eventLocation = "\(firstPlacemark.subLocality!), \(firstPlacemark.subThoroughfare!) \(firstPlacemark.thoroughfare!)  + "
//                                                            print("\(firstPlacemark.locality!)  + \(firstPlacemark.locality) + \(firstPlacemark.subLocality) + \(firstPlacemark.thoroughfare)  + \(firstPlacemark.subThoroughfare) +  + \(firstPlacemark.region)")
//                                                        }
//                                                    }
//                                        } else {
//                                            print("Your location is unknown")
//                                        }
                                    }
                                    ) {
                                Image(systemName: "location.circle.fill")
                                    .background(Color.blue.opacity(0.75))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .clipShape(Circle())
                                   // .rotationEffect(.degrees(45))
                                }
                            }}}
                    }
                    TextField("#Hashtags", text: self.$hashTags)
                        .padding()
                        .background(Color.themeTextField)
                        .foregroundColor(.black)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    TextEditor(text: self.$longDescription)
                        .id("longDescption")
                        .frame(height: 192)
                        .foregroundColor(self.longDescription == "Description" ? .gray : .black)
                        .background(Color.themeTextField)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        .onTapGesture {
                            if !longDescTapped {
                                self.longDescription = ""
                                longDescTapped = true
                            }
                            withAnimation {
                                scrollView.scrollTo("longDescption", anchor: .center)
                            }
                        }
                    
                    
                }.padding([.leading, .trailing], 50)
                
                Button(action: {viewModel.postActivity(activity: Activity(id: viewModel.getAutoUIDforActivities(), title: self.eventTitle, authorUID: user.uid ?? user.getUID()))}) {
                    Text("Post Activity")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        .padding([.bottom],20)
                }.padding(.top, 50)
                
                

            }

        }.frame(maxWidth: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }.onAppear()
    {
        print("PostActivitiyVeiw OnAppear")
    }
}
}
//
//struct PostActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostActivityView()
//    }
//}

