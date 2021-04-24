//
//  PostActivityView.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI
import MapKit
import Firebase

struct PostActivityView: View {

    private let locationManager = CLLocationManager()
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
                    TextField("#Hashtags", text: self.$hashTags)
                        .padding()
                        .background(Color.themeTextField)
                        .foregroundColor(.black)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    TextEditor(text: self.$longDescription)
                        .id("longDescption")
                        .frame(height: 100)
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
                
                Button(action:
                        {
                            ActivitiesViewModel().postActivity(activity: Activity(id: ActivitiesViewModel().getAutoUIDforActivities(), title: eventTitle))}
                ){
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
    }
    }
    }

struct PostActivityView_Previews: PreviewProvider {
    static var previews: some View {
        PostActivityView()
    }
}
