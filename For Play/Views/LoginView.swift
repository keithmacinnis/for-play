//
//  Login.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-15.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
   
    @State private var email = ""
    @State private var password = ""
    @State private var newUserSignup = false
    @State private var showingAlert = false
        
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [.green, .blue]),
        center: .center,
        startAngle: .degrees(0),
        endAngle: .degrees(360))

    
    var body: some View {
        if (!newUserSignup) {
        VStack() {
            Text("For Play")
                .font(.largeTitle).foregroundColor(Color.white)
                .padding([.top], 20)
                .shadow(radius: 10.0, x: 20, y: 10)
            Text("The Neighbourhood Connector")
                .font(.subheadline).foregroundColor(Color.black)
                .bold()
                .padding([.bottom], 40)
                .shadow(radius: 10.0, x: 20, y: 10)
            Image(systemName: "figure.walk.diamond.fill")
                .resizable()
                .foregroundColor(Color.yellow)
                .frame(width: 250, height: 250)
                .clipShape(Circle())
                .overlay(Circle().stroke(gradient, lineWidth: 4))
                .shadow(radius: 10.0, x: 20, y: 10)
                .padding(.bottom, 50)
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("Email", text: self.$email)
                    .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .padding()
                //.background(Color.themeTextField)
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .foregroundColor(.black)
                
                SecureField("Password", text: self.$password)
                    .padding()
                  //.  .background(Color.themeTextField)
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .foregroundColor(.black)
                
            }.padding([.leading, .trailing], 50)
            Button(action: {User().login(email,password)}) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }.padding(.top, 50)
            
            Spacer()
            HStack(spacing: 0) {
                Text("Don't have an account? ")
                Button(action: {newUserSignup.toggle()}) {
                        Text("Sign Up")
                            .font(.callout)
                        .foregroundColor(.black)
                            .bold()
                    
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        
    } else {
        VStack() {
            Text("For Play")
                .font(.largeTitle).foregroundColor(Color.white)
                .padding([.top], 20)
                .shadow(radius: 10.0, x: 20, y: 10)
            Text("New User Signup")
                .font(.subheadline).foregroundColor(Color.black)
                .bold()
                .padding([.bottom], 40)
                .shadow(radius: 10.0, x: 20, y: 10)
            Image(systemName: "figure.walk.diamond.fill")
                .resizable()
                .foregroundColor(Color.green)
                .frame(width: 250, height: 250)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                .shadow(radius: 10.0, x: 20, y: 10)
                .padding(.bottom, 50)
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("Email", text: self.$email)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                SecureField("Password", text: self.$password)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
            }.padding([.leading, .trailing], 50)
            Button(action: {User().register(email,password)
                
            }) {
                Text("Join For Play")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.yellow)
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }.padding(.top, 50)
            
            Spacer()
            HStack(spacing: 0) {
                Text("Already have an account? ")
                Button(action: {newUserSignup.toggle()}) {
                        Text("Sign In")
                            .font(.callout)
                        .foregroundColor(.black)
                            .bold()
                    
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        
    }
    }
    
//    func login() {
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            if error != nil {
//                print(error?.localizedDescription ?? "error")
//            } else {
//                print(result ?? "success")
//            }
//        }
//    }
//    func register() {
//        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//            if error != nil {
//                print(error?.localizedDescription ?? "error")
//            } else {
//                print(result ?? "success")
//            }
//        }
//    }
}


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
