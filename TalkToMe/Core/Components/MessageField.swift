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
    
    let greyColor = Color(red: 231/255, green: 229/255, blue:229/255)

    var body: some View {
        HStack {
            // Custom text field created below
            CustomTextField(placeholder: Text("Message..."), text: $message)
                .frame(height: 52)
                .disableAutocorrection(true)
                .padding(.horizontal)
                .background(greyColor)
                .cornerRadius(20)
              

            Button {
                messagesService.sendMessage(message, language)
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
        .cornerRadius(50)
        .padding()
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField(language: Language(title: "French", flag: "", code: "")).environmentObject(MessagesService(language: Language(title: "French", flag: "", code: "")))
    }
}

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
