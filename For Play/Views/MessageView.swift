//
//  MessageView.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-07-17.
//

import SwiftUI
import StreamChat

struct MessageView: View {
    let message: ChatMessage
       
       var background: some View {
           if (message.isSentByCurrentUser) {
               return Color.blue.opacity(0.25)
           } else {
               return Color.gray.opacity(0.25)
           }
       }
       
       var title: some View {
           if message.isSentByCurrentUser {
               return Text("")
           } else {
               return Text(message.author.id).font(.footnote)
           }
       }
       
       var body: some View {
           HStack {
               if message.isSentByCurrentUser { Spacer() }
               VStack(alignment: .leading) {
                   title
                   Text(message.text)
                   .padding(8)
                   .background(background)
                   .cornerRadius(24)
               }
               if !message.isSentByCurrentUser { Spacer() }
           }.frame(maxWidth: .infinity)
       }
   }
//
//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView("Hey mom!")
//    }
//}
