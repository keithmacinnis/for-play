//
//  User.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-15.
//

import Combine
import Foundation
import FirebaseAuth

enum LoginViewState {
    case showContent
    case showLogin
    case showSignup
}

final class User: ObservableObject {
    
    @Published var loginState: LoginViewState = Auth.auth().currentUser !=  nil ? .showContent : .showLogin
    var uid: String?
    var email: String?
    var username: String?
    var password: String?
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
      handle = Auth.auth().addStateDidChangeListener { (auth,user) in
            if user != nil {
                self.loginState = .showContent
            } else {
                print("login error from user.swift")
                self.loginState = .showLogin
            }
        }
    }
    func login(_ email: String,_ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                print(result ?? "success")
            }
        }
    }
    func register(_ email: String,_ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                print(result ?? "success")
            }
        }
    }
        
}

