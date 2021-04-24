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
        UITextView.appearance().backgroundColor = .clear
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}
