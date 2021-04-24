//
//  User.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-15.
//

import Combine
import Foundation
import FirebaseAuth


final class User: ObservableObject {
    
    @Published var loginState: LoginViewState = Auth.auth().currentUser !=  nil ? .showContent : .showLogin
    var uid: String?
    var email: String?
    var username: String?
    var password: String?
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        print("User.swift init called")
      handle = Auth.auth().addStateDidChangeListener { (auth,user) in
            if user != nil {
                self.loginState = .showContent
            } else {
                print("User is nil (from user.swift)")
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
    func logout() {
    let firebaseAuth = Auth.auth()
       do {
         try firebaseAuth.signOut()
       } catch let signOutError as NSError {
         print ("Error signing out: %@", signOutError)
       }
    }
     
        
}

