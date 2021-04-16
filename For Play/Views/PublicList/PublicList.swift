//
//  PublicList.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-14.
//



import SwiftUI

struct PublicList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false

    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }

    var body: some View {
        NavigationView {
            List {
//                Toggle(isOn: $showFavoritesOnly) {
//                    Text("Favorites only")
//                }

                ForEach(filteredLandmarks) { landmark in
                    NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct PublicList_Previews: PreviewProvider {
    static var previews: some View {
        PublicList()
            .environmentObject(ModelData())
    }
}
