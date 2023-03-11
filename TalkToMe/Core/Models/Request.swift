//
//  Request.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import Foundation

struct Request: Codable {
    let text: String
    let language : String
}


struct ErrorRootResponse: Decodable {
    let error: ErrorResponse
}

struct ErrorResponse: Decodable {
    let message: String
    let type: String?
}
