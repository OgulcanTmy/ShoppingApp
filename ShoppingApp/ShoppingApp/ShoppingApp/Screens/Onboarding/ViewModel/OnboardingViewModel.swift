//
//  OnboardingViewModel.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import Foundation
import UIKit

class OnboardingViewModel {
    var pageNumber = 0
    let pageModel = [
        OnboardingModel(title: Constants.Onboarding.title1, description: Constants.Onboarding.description1, image: Constants.Onboarding.image1),
        OnboardingModel(title: Constants.Onboarding.title2, description: Constants.Onboarding.description2, image: Constants.Onboarding.image2)
    ]
}
