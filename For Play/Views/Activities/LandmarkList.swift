///*
//See LICENSE folder for this sample’s licensing information.
//
//Abstract:
//A view showing a list of landmarks.
//*/
//
//import SwiftUI
//
//struct LandmarkList: View {
//    @ObservedObject var viewModel = ActivitiesViewModel()
//    @EnvironmentObject var modelData: ModelData
//    @State private var showFavoritesOnly = false
//    @State private var zoomStepperValue = 0
//    let zoomLevels: [String] = ["Local","Regional","Provincial","National"]
//    func incrementZoom() {
//        print(zoomStepperValue)
//
//        if zoomStepperValue < zoomLevels.count - 1 { zoomStepperValue += 1 }
//    }
//    func decrementZoom() {
//        print(zoomStepperValue)
//
//        if zoomStepperValue > 0 { zoomStepperValue -= 1
//        }
//    }
//
//    var filteredLandmarks: [Landmark] {
//        modelData.landmarks.filter { landmark in
//            (!showFavoritesOnly || landmark.isFavorite)
//        }
//    }
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.activities, id: \.self) {
//                            ActivityRow(activity: $0)
//                        }.navigationBarTitle("Breweries")
//                            .onAppear {
//                                self.viewModel.fetchBreweries()
//                            }
//
//            }
////            List {
////                Stepper(onIncrement: incrementZoom,
////                    onDecrement: decrementZoom) {
////                    Text("Zoom")
////                }
////                Toggle(isOn: $showFavoritesOnly) {
////                    Text("Favorites only")
////                }
////
////                ForEach(filteredLandmarks) { landmark in
////                    NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
////                        LandmarkRow(landmark: landmark)
////                    }
////                }
////            }
//            .navigationTitle("\(zoomLevels[zoomStepperValue]) Activities")
//        }
//    }
//}
//
//struct LandmarkList_Previews: PreviewProvider {
//    static var previews: some View {
//        LandmarkList()
//            .environmentObject(ModelData())
//    }
//}
