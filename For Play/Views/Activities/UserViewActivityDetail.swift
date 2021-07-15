//
//  UserViewActivityDetail.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-07-14.
//

import SwiftUI

struct UserViewActivityDetail: View {
    @EnvironmentObject var activityViewModel: ActivitiesViewModel
    @EnvironmentObject var user: UserViewModel


    let activity: Activity
    var body: some View {
        Text("Author")
        Text(activity.authorsUID)
        Text("id")
        Text(activity.id)
        Text("title")
        Text(activity.title)
        Text("members")
        List(activity.members, id: \.self) { member in
            Text(member)
                .moveDisabled(true)
        }
        Button(action: {
            activityViewModel.updateActivityByRemoval(activityUID: activity.id, userUID: user.getUID(), user: user)
        })
            {Text("Leave Activity")
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
}
