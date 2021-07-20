//
//  ActivtiesList.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI
import SwiftUIRefresh

struct ActivtiesList: View {
    @EnvironmentObject var avm: ActivitiesViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var zoomStepperValue = 3
    @State private var isShowing = false
    let zoomLevels: [String] = ["National","Provincial","Regional","Local"]
    @State private var isFiltered = false
    var body: some View {
        List {
            Stepper("", value: $zoomStepperValue, in: 0...3)
            Toggle("Filter", isOn: $isFiltered)
                .onChange(of: isFiltered ) { _ in
                    avm.refreshFilteredActivtivties(userID: userViewModel.getUID())
            }
            if !isFiltered {
            ForEach(avm.activities) { activity in
                NavigationLink(destination: ActivityDetail(activity: activity )) {
                    ActivityRow(currentActivity: activity)
                }
            }
            } else {
            ForEach(avm.filteredActivities) { activity in
                NavigationLink(destination: ActivityDetail(activity: activity )) {
                    ActivityRow(currentActivity: activity)
                }
            }
            }
        }
        .pullToRefresh(isShowing: $isShowing) {
            if !isFiltered {
                avm.fetchActivties()
            }
            else {
                avm.refreshFilteredActivtivties(userID: userViewModel.getUID())
            }
            self.isShowing = false
        }
        .navigationTitle("\(zoomLevels[zoomStepperValue]) Activities")
    }
}
