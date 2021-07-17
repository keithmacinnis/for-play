//
//  ActivityDetail.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI
import MapKit
struct ActivityDetail: View {
    @EnvironmentObject var activityViewModel: ActivitiesViewModel
    @EnvironmentObject var user: UserViewModel
    
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 420, longitudinalMeters: 420)
    let activity: Activity

    var body: some View {
        ScrollView {
            Text("Title: \(activity.title)")
                .bold()
            VStack {
                Spacer()
                Map(coordinateRegion: $region, interactionModes: [] )
                    .frame(height: 300)
                    .padding(.bottom, -130)
                Image(systemName: "figure.walk.diamond.fill")
                    .foregroundColor(Color.blue.opacity(0.75))
                Spacer()
            }
            Group{
                Text("Author")
                Text(activity.authorsUID)
                Text("id")
                Text(activity.id)
                Text("members")
                List(activity.members, id: \.self) { dude in
                    Text(dude)
                        .moveDisabled(true)
                }
            }
            Button(action: {
                activityViewModel.updateActivity(activityUID: activity.id, userUID: user.getUID(), user: user)
            })
                {Text("Join Activity")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding([.bottom],20)
            }.padding(.top, 50)
            .onAppear() {
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: activity.coordinates!.latitude, longitude: activity.coordinates!.longitude), latitudinalMeters: 420, longitudinalMeters: 420)
            }
        }
    }
}
