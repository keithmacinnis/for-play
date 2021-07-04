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
    @EnvironmentObject var user: UserViewModel
    
    @State var region: MKCoordinateRegion
    @Binding var parentsTab: Tab
    
    @State private var locations = [MKPointAnnotation]()
    @State private var userTracking = MapUserTrackingMode.follow
    @State private var eventTitle = ""
    @State private var eventPassword = ""
    @State private var eventActivity = ""
    @State private var eventLocation = "Location/GPS (Click the map's checkmark to set me)"
    @State private var hashTags = ""
    @State private var date = Date()
    @State private var isPrivate = false
    @State private var longDescription: String = "Description"
    @State private var longDescTapped = false
    @State private var scrollTarget: Int?
    @State private var dateSelected = false
    @State private var showingAlert = false
    @State private var showingSuccess = false
    @State private var activeAlert: ActiveAlert = .postWarning
    
    let dateRange: ClosedRange<Date> = {
        let now = Date()
        let currentMinuteTime = Calendar.current.component(.minute, from: now)
        let startingTime = Calendar.current.date(byAdding: .minute, value: 1440 + (60-currentMinuteTime), to: now)
        let endingTime = Calendar.current.date(byAdding: .month, value: 6, to: now)
        return startingTime! ... endingTime!
    }()

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
                    .onTapGesture {
                        dateSelected = true
                    }
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
                    ForPlay_MapView(region: $region, userTracking: $userTracking, locations: $locations, eventLocation: $eventLocation)
//                ZStack{
//                    Map(coordinateRegion: $region, interactionModes: [MapInteractionModes.all], showsUserLocation: true, userTrackingMode: $userTracking)
//                        .frame( height: 386)
//                        .frame(height: 256)
//                        .cornerRadius(25.0)
//                        .shadow(radius: 10.0, x: 20, y: 10)
//                    Circle()
//                        .fill(Color.blue)
//                        .opacity(0.3)
//                        .frame(width: 16, height: 16)
//                    Circle()
//                        .fill(Color.black)
//                        .opacity(0.3)
//                        .frame(width: 1, height: 1)
//                    HStack {
//                        Spacer()
//                        VStack {
//                        Spacer()
//                        HStack(){
//                            VStack(){
//                                Button(action: {zoom()}) {Image(systemName: "location.circle.fill")
//                                    .background(Color.blue.opacity(0.75))
//                                    .foregroundColor(.white)
//                                    .font(.title)
//                                    .clipShape(Circle())
//                                    .rotationEffect(.degrees(30))
//                                }
//                            }
//                            VStack(){
//                                Button(action: {saveCrosshairLocation()}) {
//                                Image(systemName: "checkmark.circle.fill")
//                                    .background(Color.blue.opacity(0.75))
//                                    .foregroundColor(.white)
//                                    .font(.title)
//                                    .clipShape(Circle())
//                                }
//                            }}}
//                        }
//                    }
                    TextEditor(text: self.$eventLocation)
                        .frame(height: 48)
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
                    TextField("#Hashtags", text: self.$hashTags)
                        .padding()
                        .background(Color.themeTextField)
                        .foregroundColor(.black)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    
                    
                }.padding([.leading, .trailing], 50)
                
                Button(action: {
                    if eventTitle == "" || !dateSelected || eventActivity == "" || eventLocation == "Location/GPS (Click the map's checkmark to set me)"{
                        activeAlert = .postWarning
                    } else {
                        activeAlert = .postSuccess
                    }
                    showingAlert = true
                })
                    {Text("Post Activity")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        .padding([.bottom],20)
                }.padding(.top, 50)
                .alert(isPresented: $showingAlert, content: {
                    switch activeAlert {
                        case .postWarning :
                            return Alert(title: Text("Insufficient Details"), message:  Text("You need to add details above. Remember to set your date"), dismissButton: .default(Text("Got it!")))
                        case .postSuccess :
                            return  Alert(title: Text("Are you sure you want to post this?"), message: Text("You can edit details, after postinig, under the 'profile->your activtiies' tab"), primaryButton: .default(Text("Post"), action: postActivity), secondaryButton: .cancel())
                    }
                })
            }
        }
        .frame(maxWidth: .infinity)
        .background (LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
    func clearForm() {
        eventTitle = ""
        eventPassword = ""
        eventActivity = ""
        eventLocation = "Location/GPS (Click the map's checkmark to set me)"
        hashTags = ""
        date = Date()
        isPrivate = false
        longDescription = "Description"
        longDescTapped = false
        dateSelected = false
        showingAlert = false
        showingSuccess = false
        activeAlert = .postWarning
    }
    func postActivity() {
        viewModel.postActivity(activity: Activity(id: viewModel.getAutoUIDforActivities(), title: self.eventTitle, authorUID: user.uid ?? user.getUID()))
        clearForm()
        self.parentsTab = .usersPage
        
    }
    func isActivitySubmitable() {
        if eventTitle == "" || !dateSelected || eventActivity == "" || eventLocation == "Location/GPS (Click the map's checkmark to set me)"{
            showingAlert = true
        } else {
            showingSuccess = true
        }
    }
//    func saveCrosshairLocation() {
//            let newLocation = MKPointAnnotation()
//            newLocation.coordinate = self.region.center
//            self.locations.append(newLocation)
//            let local: CLLocation = CLLocation(latitude: self.region.center.latitude , longitude: self.region.center.longitude)
//            CLGeocoder().reverseGeocodeLocation(local) { (placemarks, error) in
//                guard error == nil else {
//                    print("ReverseGeocode Error: \(String(describing: error))")
//                    return
//                }
//                if let firstPlacemark = placemarks?.first {
//                    print(firstPlacemark)
//                    var addressString : String = ""
//                    if firstPlacemark.name != nil {
//                        addressString = addressString + firstPlacemark.name! + ", "
//                    }else {
//                        if firstPlacemark.subThoroughfare != nil {
//                            addressString = addressString + firstPlacemark.subThoroughfare! + ", "
//                        }
//                        if firstPlacemark.thoroughfare != nil {
//                            addressString = addressString + firstPlacemark.thoroughfare! + ", "
//                        }
//                    }
//                    if firstPlacemark.subLocality != nil {
//                        addressString = addressString + firstPlacemark.subLocality! + ", "
//                    }
//                    if firstPlacemark.locality != nil {
//                        addressString = addressString + firstPlacemark.locality! + ", "
//                    }
//                    if firstPlacemark.country != nil {
//                        addressString = addressString + firstPlacemark.country! + ", "
//                    }
//                    if firstPlacemark.postalCode != nil {
//                        addressString = addressString + firstPlacemark.postalCode! + ", "
//                    }
//                    if firstPlacemark.region != nil {
//                        addressString = addressString + "<\(local.coordinate.latitude),\(local.coordinate.longitude)>"
//                    }
//                    self.eventLocation = addressString
//                }
//            }
//        }
//    func zoom() {
//        let newZoom = 0.08
//        self.region = MKCoordinateRegion(center: user.getLocation(), span:  MKCoordinateSpan(latitudeDelta: newZoom, longitudeDelta: newZoom))
//    }
}
//
//struct PostActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostActivityView()
//    }
//}
