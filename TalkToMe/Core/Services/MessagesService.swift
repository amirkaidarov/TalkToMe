//
//  MessagesService.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessagesService: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId: String = ""
    var language : Language  //= Language(title: "French", flag: "France", code: "fr-FR")
    let db = Firestore.firestore()
    
    init(language : Language) {
        self.language = language
        self.getMessages()
    }
    
    func getMessages() {
        db.collection("languages")
            .document(language.title.lowercased())
            .collection("messages")
            .addSnapshotListener { querySnapshot, error in
            print("Listening...")
            
            // If we don't have documents, exit the function
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            // Mapping through the documents
            self.messages = documents.compactMap { document -> Message? in
                do {
                    // Converting each document into the Message model
                    // Note that data(as:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
                    return try document.data(as: Message.self)
                } catch {
                    // If we run into an error, print the error in the console
                    print("Error decoding document into Message: \(error)")

                    // Return nil if we run into an error - but the compactMap will not include it in the final array
                    return nil
                }
            }
            
            // Sorting the messages by sent date
            self.messages.sort { $0.timestamp < $1.timestamp }
            
            // Getting the ID of the last message so we automatically scroll to it in ContentView
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }
    
    func sendMessage(_ text : String, _ language : Language) {
        print("sending my message...")
        sendToFirebase(text: text, received: false)
        self.language = language
            
        let body: [String: Any] = ["text" : text, "language" : language.code]

        let jsonData = try? JSONSerialization.data(withJSONObject: body)

        let url = URL(string: "https://3e50-144-118-77-33.ngrok.io/generate-response")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData


        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }

            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("-----2> responseJSON: \(responseJSON["text"]!)")
                let responseToFirebase = responseJSON["text"] as? String
                self.sendToFirebase(text: responseToFirebase ?? "Hi", received: true)
                print("sending response...")
            }
        }

        task.resume()
    }
    
    func sendToFirebase(text: String, received : Bool){
        do {
            // Create a new Message instance, with a unique ID, the text we passed, a received value set to false (since the user will always be the sender), and a timestamp
            let newMessage = Message(id: "\(UUID())", text: text, received: received, timestamp: Date())
            
            // Create a new document in Firestore with the newMessage variable above, and use setData(from:) to convert the Message into Firestore data
            // Note that setData(from:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
            try db
                .collection("languages")
                .document(language.title.lowercased())
                .collection("messages")
                .document().setData(from: newMessage)
        
        } catch {
            // If we run into an error, print the error in the console
            print("Error adding message to Firestore: \(error)")
        }
    }
    
    private func jsonBody(text: String, stream: Bool = true) throws -> Data {
        let request = Request(text: text, language: language.code)
        return try JSONEncoder().encode(request)
    }

}

extension String: CustomNSError {
    
    public var errorUserInfo: [String : Any] {
        [
            NSLocalizedDescriptionKey: self
        ]
    }
}
