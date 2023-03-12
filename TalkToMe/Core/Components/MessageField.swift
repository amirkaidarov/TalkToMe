//
//  MessageField.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import SwiftUI

struct MessageField: View {
    @EnvironmentObject var messagesService: MessagesService
    @State private var message = ""
    var language : Language

    var body: some View {
        HStack {
            // Custom text field created below
            CustomTextField(placeholder: Text("Message..."), text: $message)
                .frame(height: 52)
                .disableAutocorrection(true)

            Button {
                messagesService.sendMessage(message, language.code)
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.purple)
                    .padding(10)
                    .cornerRadius(50)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("Gray"))
        .cornerRadius(50)
        .padding()
    }
}

//struct MessageField_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageField()
//            .environmentObject(MessagesService())
//    }
//}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            // If text is empty, show the placeholder on top of the TextField
            if text.isEmpty {
                placeholder
                .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
