//
//  SplashViewModel.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import Foundation

enum SplashStateChange {
    case navigateToMain
    case navigateToLogin
    case navigateToOnboarding
}

class SplashViewModel {
    let constants = Constants.Defaults.self
    
    var changeHandler: ((SplashStateChange) -> Void)?
    
    func checkUserStatus() {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: constants.isPassedOnboarding) {
            if defaults.bool(forKey: constants.isLoggedIn) {
                changeHandler?(.navigateToMain)
            } else {
                changeHandler?(.navigateToLogin)
            }
        } else {
            changeHandler?(.navigateToOnboarding)
        }
    }
}
