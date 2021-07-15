//
//  UserView.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI

struct UserView: View { 
    @EnvironmentObject var user: UserViewModel
    @State var userName: String = "anonymous1"
    
    var body: some View {
        NavigationView {
        VStack() {
            Image(systemName: "person.crop.circle")
                .resizable()
                .foregroundColor(Color.yellow)
                .frame(width: 250, height: 250)
                .clipShape(Circle())
                .overlay(Circle().stroke(gradient, lineWidth: 4))
                .shadow(radius: 10.0, x: 20, y: 10)
                
            Text("\(userName): Member Since 2021")
                .shadow(radius: 10.0, x: 20, y: 10)
                .padding(.bottom, 50)
            Spacer()
            VStack(alignment: .leading, spacing: 15) {
                NavigationLink(destination: UserViewActivitiesList()) {
                                            Text("Your Activities")
                            .frame(width: 200, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(Color.themeTextField)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    }
                
                NavigationLink( destination: JoinUnlistedView() ) {
                        Text("Join Unlisted")
                            .frame(width: 200, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(Color.themeTextField)
                        .cornerRadius(25.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }

                Button(action: {UserViewModel().logout()}) {
                    Text("Logout")
                    .frame(width: 200, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                        .background(Color.themeTextField)
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                        .padding([.bottom],20)
                        
                }
                
            }.padding([.leading, .trailing], 50)
            
            

        }.frame(maxWidth: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))

        }.onAppear {
            userName = user.getEmail()
        }
    }
}
//
//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
