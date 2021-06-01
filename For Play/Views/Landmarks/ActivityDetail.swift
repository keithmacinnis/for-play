//
//  ActivityDetail.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI

struct ActivityDetail: View {
    @EnvironmentObject var activityViewModel: ActivitiesViewModel

    let activity: Activity
    var body: some View {
        Text("Author")
        Text(activity.authorsUID)
        Text("id")
        Text(activity.id)
        Text("title")
        Text(activity.title)
        Text("members")
        Text(activity.members[0])
        Button(action: {
            activityViewModel.updateActivity(activityUID: activity.id)
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
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail(activity: Activity( id: "1", title: "String", authorUID: "asdfa"))
    }
}

