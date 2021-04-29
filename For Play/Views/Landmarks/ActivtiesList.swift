//
//  ActivtiesList.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI

struct ActivtiesList: View {
    @EnvironmentObject var viewModel: ActivitiesViewModel
    @State private var zoomStepperValue = 2
    let zoomLevels: [String] = ["National","Provincial","Regional","Local"]
    
    func incrementZoom() {
        print(zoomStepperValue)
        if zoomStepperValue < zoomLevels.count - 1 { zoomStepperValue += 1 }
    }
    func decrementZoom() {
        print(zoomStepperValue)
        if zoomStepperValue > 0 { zoomStepperValue -= 1 }
    }
 
    var body: some View {
        NavigationView {
            List {
                Stepper(onIncrement: incrementZoom, onDecrement: decrementZoom) {
                    Text("Zoom")
                }
                ForEach(viewModel.activities) { activity in
                    NavigationLink(destination: ActivityDetail(activity: activity)) {
                        ActivityRow(currentActivity: activity)
                    }
                }
            }
            .navigationTitle("\(zoomLevels[zoomStepperValue]) Activities")
            .onAppear {
                self.viewModel.fetchActivties()
            }
            
        }
    }

struct ActivtiesList_Previews: PreviewProvider {
    static var previews: some View {
        ActivtiesList()
    }
}
}

