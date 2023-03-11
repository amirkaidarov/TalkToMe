//
//  AuthViewModel.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import Foundation

class AuthViewModel : ObservableObject {
    
    @Published var isOnBoardingViewInactive : Bool = false
    
    func toggle() {
        isOnBoardingViewInactive = !isOnBoardingViewInactive
    }
    
}
