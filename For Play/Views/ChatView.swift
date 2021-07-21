//
//  ChatView.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-07-17.
//

import SwiftUI
import StreamChat

struct ChatView: View {
    @StateObject var channel: ChatChannelController.ObservableObject
    @State var text: String = ""
    @State var isShowing: Bool = false
    var body: some View {
        VStack {
            List(channel.messages, id: \.self) {
                MessageView(message: $0)
                    .scaleEffect(x: 1, y: -1, anchor: .center)
            }
            .pullToRefresh(isShowing: $isShowing) {
                self.channel.controller.synchronize()
                self.isShowing = false
            }
            .scaleEffect(x: 1, y: -1, anchor: .center)
            .offset(x: 0, y: 2)
            HStack {
                TextField("Type a message", text: $text)
                Button(action: self.send) {
                    Text("Send")
                }
            }.padding()
        }
        .navigationBarTitle("G Chat")
        .onAppear(perform: { self.channel.controller.synchronize() })
    }
    func send() {
            channel.controller.createNewMessage(text: text) {
                switch $0 {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error)
                    }
            }
            self.text = ""
        }
    }
