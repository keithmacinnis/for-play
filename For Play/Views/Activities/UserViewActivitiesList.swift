//
//  UserViewActivitiesList.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-07-14.
//

import SwiftUI
import SwiftUIRefresh

struct UserViewActivitiesList: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var activityViewModel: ActivitiesViewModel
    
    @State private var isShowing = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userViewModel.activities) { activity in
                    NavigationLink(destination: UserViewActivityDetail(activity: activity)) {
                        ActivityRow(currentActivity: activity)
                    }
                }
            }
            .pullToRefresh(isShowing: $isShowing) {
                userViewModel.fetchActivties(act: activityViewModel)
                self.isShowing = false
            }
            .navigationTitle("Your Activities")
        }.onAppear() {
            userViewModel.fetchActivties(act: activityViewModel)
        }
    }
}
