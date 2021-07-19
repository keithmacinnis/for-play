//
//  UserView.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI

struct JoinUnlistedView: View {
    @EnvironmentObject var avm: ActivitiesViewModel
    @EnvironmentObject var user: UserViewModel
    @State private var eventTitle = ""
    @State private var eventPassword = ""
    
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [.green, .blue]),
        center: .center,
        startAngle: .degrees(0),
        endAngle: .degrees(360))
    
    var body: some View {
        VStack() {
            Image(systemName: "lock.circle.fill")
                .resizable()
                .foregroundColor(Color.yellow)
                .frame(width: 175, height: 175)
                .clipShape(Circle())
                .overlay(Circle().stroke(gradient, lineWidth: 4))
                .shadow(radius: 10.0, x: 20, y: 10)
            Spacer()
            VStack(alignment: .leading, spacing: 15) {
                TextField("Event Title", text: self.$eventTitle)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                SecureField("Password", text: self.$eventPassword)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
            }.padding([.leading, .trailing], 50)
            Button(action: {
                avm.validatePasswordTitlePair(title: eventTitle, password: eventPassword, user: user)
            }) {
                Text("Join Unlisted Activity")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding([.bottom],20)
            }.padding(.top, 50)
            
            

        }.frame(maxWidth: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))

    }
    
}

struct JoinUnlistedView_Previews: PreviewProvider {
    static var previews: some View {
        JoinUnlistedView()
    }
}
