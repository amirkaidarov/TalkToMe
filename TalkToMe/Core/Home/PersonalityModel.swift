//
//  PersonalityModel.swift
//  TalkToMe
//
//  Created by Channacy Un on 3/12/23.
//

import Foundation

struct Personality : Identifiable {
    let id = UUID()
    let name : String
    let language : String
    let flag : String
    let code : String
}
