//
//  MessageBubble.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    
    var body: some View {
        let purpleColor = Color(red: 115/255, green: 113/255, blue:252/255)

        VStack(alignment: message.received ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .foregroundColor(message.received ? Color.black : Color.white)
                    .background(message.received ? Color.gray.opacity(0.1) : purpleColor )
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: UUID().uuidString, text: "I've been coding applications from scratch in SwiftUI and it's so much fun!", received: false, timestamp: Date.now))
    }
}
