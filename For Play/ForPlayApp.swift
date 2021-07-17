//
//  For_PlayApp.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-14.
//

import SwiftUI
import Firebase
import MapKit
import StreamChat

@main
struct ForPlayApp: App {
    @StateObject private var activityData = ActivitiesViewModel()
    @StateObject private var user = UserViewModel()
    private var streamChatAPIKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "StreamChatAPI", ofType: "plist") else {
          fatalError("Couldn't find file 'StreamChatAPI.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "api_key") as? String else {
          fatalError("Couldn't find key api_key in 'StreamChatAPI.plist'.")
        }
        return value
      }
    }
    init() {
        FirebaseApp.configure()
        let chatConfig = ChatClientConfig(apiKeyString: streamChatAPIKey)
        ChatClient.shared = ChatClient(config: chatConfig, tokenProvider: .anonymous)
        //UI Enhancements
        UITextView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(activityData)
                .environmentObject(user)
        }
    }
}

extension ChatClient {
    static var shared: ChatClient!
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}


let gradient = AngularGradient(
    gradient: Gradient(colors: [.green, .blue]),
    center: .center,
    startAngle: .degrees(0),
    endAngle: .degrees(360))

enum ThreeActiveAlerts {
    case first
    case second
    case third
}

enum LoginViewState {
    case showContent
    case showLogin
    case showSignup
}

enum ActiveAlert {
    case postWarning, postSuccess
}

enum Tab {
    case post
    case usersPage
    case publicList
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Whistler"
        annotation.subtitle = "Home to the 2010 Winter Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: -50.154164, longitude: -122.96390)
        return annotation
    }
}
