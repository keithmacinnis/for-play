//
//  ContentView.swift
//  For Play: The Neighbourhood Connector
//
//  Created by Keith MacInnis on 2021-04-14.
//


import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State private var selection: Tab = .publicList
    @EnvironmentObject var user: User
    
    enum Tab {
        case post
        case usersPage
        case publicList
    }
    
    var body: some View {
        switch user.loginState {
            case .showContent:
                TabView(selection: $selection) {
                    PostActivityView(region: user.getLocation())
                        .tabItem {
                            Label("Post", systemImage: "paperplane")
                        }
                        .tag(Tab.post)
                    UserView()
                        .tabItem {
                            Label("User", systemImage: "person")
                        }
                        .tag(Tab.usersPage)
                    ActivtiesList()
                        .tabItem {
                            Label("Public", systemImage: "list.bullet.rectangle")
                        }
                        .tag(Tab.publicList)
                }
            case .showLogin:
                LoginView()
            case .showSignup:
                LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(User())
    }
}


