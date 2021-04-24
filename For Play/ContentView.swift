//
//  ContentView.swift
//  For Play: The Neighbourhood Connector
//
//  Created by Keith MacInnis on 2021-04-14.
//


import SwiftUI
import FirebaseAuth

let gradient = AngularGradient(
    gradient: Gradient(colors: [.green, .blue]),
    center: .center,
    startAngle: .degrees(0),
    endAngle: .degrees(360))

enum LoginViewState {
    case showContent
    case showLogin
    case showSignup
}

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
                    PostActivityView()
                        .tabItem {
                            Label("Post", systemImage: "paperplane")
                        }
                        .tag(Tab.featured)

                    UserView()
                        .tabItem {
                            Label("User", systemImage: "person")
                        }
                        .tag(Tab.list)
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
            .environmentObject(ModelData())
    }
}


