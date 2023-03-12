//
//  ChatView.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import SwiftUI

struct ChatView: View {
    let language : Language
    @StateObject var messagesService = MessagesService()
    
    var body: some View {
        VStack {
            VStack {
                TitleRow(language: language)
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messagesService.messages, id: \.id) { message in
                            MessageBubble(message: message)
                        }
                    }
                    .padding(.top, 10)
                    .background(.white)
                    .cornerRadius(30, corners: [.topLeft, .topRight])

                    .onChange(of: messagesService.lastMessageId) { id in
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
            }
            
            MessageField(language: language)
                .environmentObject(messagesService)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(language: Language(title: "French", flag: "France", code: "fr-FR"))
    }
}
