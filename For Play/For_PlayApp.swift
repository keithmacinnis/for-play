//
//  For_PlayApp.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-14.
//

import SwiftUI
import Firebase

@main
struct For_PlayApp: App {
    @StateObject private var modelData = ModelData()
    
    init() {
       FirebaseApp.configure()
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
