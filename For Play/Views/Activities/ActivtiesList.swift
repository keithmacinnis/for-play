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
    @State private var zoomStepperValue = 2
    @State private var isRefreshSpinnerShowing = false
    let zoomLevels: [String] = ["National","Regional","Local"]
    /*
     1° = 111 km (or 60 nautical miles) 0.1° = 11.1 km.
     
     2 Local : 11km * 11km   //eg metro van
     1 Regional : 220 * 220 km
     0 National : Country = Country
     */
    
    @State private var isFiltered = true
    var body: some View {
        List {
            Stepper("", value: $zoomStepperValue, in: 0...2)
                .onChange(of: zoomStepperValue) { _ in
                    avm.refreshFilteredActivtivties(userID: userViewModel.getUID(), zoom: zoomStepperValue, usersCordinate: userViewModel.getLocationCords())
                }
            ForEach(avm.filteredActivities) { activity in
               NavigationLink(destination: ActivityDetail(activity: activity )) {
                   ActivityRow(currentActivity: activity)
               }
            }
        }
        .pullToRefresh(isShowing: $isRefreshSpinnerShowing) {
            avm.refreshFilteredActivtivties(userID: userViewModel.getUID(), zoom: zoomStepperValue, usersCordinate: userViewModel.getLocationCords())
            self.isRefreshSpinnerShowing = false
        }
        .navigationTitle("\(zoomLevels[zoomStepperValue]) Activities")
        .onAppear {
            avm.refreshFilteredActivtivties(userID: userViewModel.getUID(), zoom: zoomStepperValue, usersCordinate: userViewModel.getLocationCords())

        }
    }
}
