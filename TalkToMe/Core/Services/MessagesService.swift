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
    
//    private var urlRequest: URLRequest {
//        let url = URL(string: "https://3e50-144-118-77-33.ngrok.io/generate-response")!
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        return urlRequest
//    }
//    private let urlSession = URLSession.shared
//
//    private let jsonDecoder: JSONDecoder = {
//        let jsonDecoder = JSONDecoder()
//        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//        return jsonDecoder
//    }()
    
    // On initialize of the MessagesManager class, get the messages from Firestore
    init() {
        getMessages()
    }
    
    // Read message from Firestore in real-time with the addSnapShotListener
    func getMessages() {
        self.messages = [Message(id: UUID(), text: "Hello", received: true),
                         Message(id: UUID(), text: "How are you", received: false)]
    }
    
//    func sendMessage(_ text: String) async throws -> String {
//        var urlRequest = self.urlRequest
//        urlRequest.httpBody = try jsonBody(text: text, stream: false)
//        print(urlRequest.httpBody?.description ?? "nothing here")
//
//        let (data, response) = try await urlSession.data(for: urlRequest)
//
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw "Invalid response"
//        }
//
//        guard 200...299 ~= httpResponse.statusCode else {
//            var error = "Bad Response: \(httpResponse.statusCode)"
//            if let errorResponse = try? jsonDecoder.decode(ErrorRootResponse.self, from: data).error {
//                error.append("\n\(errorResponse.message)")
//            }
//            throw error
//        }
//
//        do {
//            let result = try self.jsonDecoder.decode(MessageData.self, from: data)
//            print("Hello")
//            print(result.text)
//            return result.text
//        } catch {
//            throw error
//
//        }
//
//    }
    
    func sendMessage(_ text : String) {
            
        let body: [String: Any] = ["text" : "Hello", "language" : "fr-FR"]
            
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        let url = URL(string: "https://3e50-144-118-77-33.ngrok.io/generate-response")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("-----> data: \(data)")
            print("-----> error: \(error)")
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }

            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            print("-----1> responseJSON: \(responseJSON)")
            if let responseJSON = responseJSON as? [String: Any] {
                print("-----2> responseJSON: \(responseJSON)")
            }
        }
        
        task.resume()
    }
    
    func setLanguage(_ language : String) {
        self.language = language
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
