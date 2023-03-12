//
//  HomeViewModel.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/12/23.
//

import Foundation

class HomeViewModel : ObservableObject {
    @Published var languages = [Language(title: "French", flag: "France", code: "fr-FR"),
                             Language(title: "Russian", flag: "Russia", code: "ru-RU"),
                             Language(title: "Spanish", flag: "Spain", code: "es-ES")]
    @Published var searchText = ""
    var searchableLanguages : [Language] {
        if searchText.isEmpty {
            return languages
        } else {
            let searchQuery = searchText.lowercased()
            
            return languages.filter({
                $0.title.lowercased().contains(searchQuery) ||
                $0.code.lowercased().contains(searchQuery)
            })
        }
    }
}
