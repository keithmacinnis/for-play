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
    @StateObject var user = User()
    
    enum Tab {
        case featured
        case list
        case publicList
    }
    
    var body: some View {
        switch user.loginState {
            case .showContent:
                TabView(selection: $selection) {
                    CategoryHome()
                        .tabItem {
                            Label("Featured", systemImage: "star")
                        }
                        .tag(Tab.featured)

                    LandmarkList()
                        .tabItem {
                            Label("List", systemImage: "list.bullet")
                        }
                        .tag(Tab.list)
                    LandmarkList()
                        .tabItem {
                            Label("Public", systemImage: "list.bullet")
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
            .environmentObject(ModelData())
    }
}
