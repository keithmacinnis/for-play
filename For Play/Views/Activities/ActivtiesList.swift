//
//  ActivtiesList.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI
import SwiftUIRefresh

struct ActivtiesList: View {
    @EnvironmentObject var viewModel: ActivitiesViewModel
    @State private var zoomStepperValue = 3
    @State private var isShowing = false
    let zoomLevels: [String] = ["National","Provincial","Regional","Local"]
    
    var body: some View {
        NavigationView {
            List {
                Stepper("", value: $zoomStepperValue, in: 0...3)
                ForEach(viewModel.activities) { activity in
                    NavigationLink(destination: ActivityDetail(activity: activity)) {
                        ActivityRow(currentActivity: activity)
                    }
                }
            }
            .pullToRefresh(isShowing: $isShowing) {
                viewModel.fetchActivties()
                self.isShowing = false
            }
            .navigationTitle("\(zoomLevels[zoomStepperValue]) Activities")
        }
    }
    struct ActivtiesList_Previews: PreviewProvider {
        static var previews: some View {
            ActivtiesList()
        }
    }
}

