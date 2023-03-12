//
//  MessagesService.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import Foundation

class MessagesService: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId: String = ""
    private var language : String = ""
    
    init() {
        getMessages()
    }
    
    func getMessages() {
        self.messages = [Message(id: UUID(), text: "Hello", received: true),
                         Message(id: UUID(), text: "How are you", received: false)]
    }
    
    func sendMessage(_ text : String, _ language : String) {
        self.language = language
            
        let body: [String: Any] = ["text" : text, "language" : language]

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
            }
        }

        task.resume()
    }
    
    private func jsonBody(text: String, stream: Bool = true) throws -> Data {
        let request = Request(text: text, language: language)
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
