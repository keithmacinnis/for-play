//
//  PostActivityView.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI
import MapKit

struct PostActivityView: View {
    @EnvironmentObject var activityViewModel: ActivitiesViewModel
    @EnvironmentObject var user: UserViewModel
    
    @State var region: MKCoordinateRegion
    @Binding var parentsTab: Tab
    
    @State private var locations = [MKPointAnnotation]()
    @State private var userTracking = MapUserTrackingMode.follow
    @State private var cordsOfEvent = Coordinates(latitude: 0, longitude: 0)
    @State private var eventTitle = ""
    @State private var eventPassword = ""
    @State private var eventActivity = ""
    @State private var eventLocation = "Location (Tap CheckMark to Set Location)"
    @State private var hashTags = ""
    @State private var date = Date()
    @State private var isPrivate = false
    @State private var longDescription: String = "A Long Description (optional)"
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
                    TextField("Event Title (eg. Hockey Tournry 21')", text: self.$eventTitle)
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
                    TextField("Activity Type (eg. Road Hockey)", text: self.$eventActivity)
                        .padding()
                        .background(Color.themeTextField)
                        .foregroundColor(.black)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    ForPlay_MapView(region: $region, userTracking: $userTracking, locations: $locations, eventLocation: $eventLocation, cordsOfEvent: $cordsOfEvent)
                    VStack{
                        Text(eventLocation)
                            .font(Font.custom("SF Mono Regular", size: 11))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        HStack{
                            Spacer()
                            Text("Lat: \(cordsOfEvent.latitude)").font(Font.custom("SF Mono Regular", size: 11)).foregroundColor(.black).fontWeight(.bold)
                            Text("Lon: \(cordsOfEvent.longitude)").font(Font.custom("SF Mono Regular", size: 11)).foregroundColor(.black).fontWeight(.bold)
                            Spacer()
                        }
                    }.frame(alignment: .center)
//                    TextEditor(text: self.$longDescription)
//                        .id("longDescption")
//                        .frame(height: 192)
//                        .foregroundColor(self.longDescription == "Description" ? .gray : .black)
//                        .background(Color.themeTextField)
//                        .cornerRadius(25.0)
//                        .shadow(radius: 10.0, x: 20, y: 10)
//                        .onTapGesture {
//                            if !longDescTapped {
//                                self.longDescription = ""
//                                longDescTapped = true
//                            }
//                            withAnimation {
//                                scrollView.scrollTo("longDescption", anchor: .center)
//                            }
//                        }
//
//                    TextField("#Hashtags (optional)", text: self.$hashTags)
//                        .padding()
//                        .background(Color.themeTextField)
//                        .foregroundColor(.black)
//                        .cornerRadius(25.0)
//                        .shadow(radius: 10.0, x: 20, y: 10)
                    
                    
                }.padding([.leading, .trailing], 50)
                
                Button(action: {
                    if eventTitle == "" || !dateSelected || eventActivity == "" || eventLocation == "Tap CheckMark To Save Location"{
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
                            return Alert(title: Text("Insufficient Details"), message:  Text("You need to add details above... Remember to set your date and location..."), dismissButton: .default(Text("Got it!")))
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
        eventLocation = "Location (Tap CheckMark to Set Location)"
        cordsOfEvent = Coordinates(latitude: 0, longitude: 0)
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
        activityViewModel.postActivity(title: self.eventTitle, authorUID: user.uid ?? user.getUID(), date: self.date , user: user, cordsOfEvent: self.cordsOfEvent, isPrivate: self.isPrivate, password: self.eventPassword)
        clearForm()
        self.parentsTab = .usersPage
    }
    func isActivitySubmitable() {
        if eventTitle == "" || !dateSelected || eventActivity == "" || eventLocation == "Location (Tap CheckMark to Set Location)" {
            showingAlert = true
        } else {
            showingSuccess = true
        }
    }
}
