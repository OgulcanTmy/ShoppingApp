//
//  Constants.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import Foundation

enum Constants {
    enum Defaults {
        static let isPassedOnboarding = "isPassedOnboarding"
        static let isLoggedIn = "isLoggedIn"
        static let uid = "uid"
    }
    
    enum Onboarding {
        static let next = "Sonraki >"
        static let start = "Başla"

        static let title1 = "Özel\nFiyatlarla"
        static let title2 = "Özel\nFiyatlarla"
        
        static let description1 = "Alışveriş artık\nhem daha kolay\nhem daha hesaplı"
        static let description2 = "İhtiyaçlarınıza kolay\nve hızlı şekilde\nulaşın"
        
        static let image1 = "onboarding1"
        static let image2 = "onboarding2"
    }

    enum Authentication {
        static let register = "Kayıt Ol"
        static let haveAccount = "Hesabın var mı? Giriş yap"

        static let login = "Giriş Yap"
        static let dontHaveAccount = "Hesabın yok mu? Kayıt ol"

        static let users = "users"
    }

    enum TabBar {
        static let products = "Ürünler"
        static let productsIcon = "homeIcon"

        static let search = "Ara"
        static let searchIcon = "searchIcon"

        static let profile = "Profil"
        static let profileIcon = "profileIcon"
    }
}
