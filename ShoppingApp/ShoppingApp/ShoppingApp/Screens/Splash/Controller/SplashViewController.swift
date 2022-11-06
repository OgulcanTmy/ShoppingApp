//
//  SplashViewController.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let viewModel = SplashViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: viewModel.checkUserStatus)
        viewModel.changeHandler = { state in
            switch state {
                case .navigateToMain:
                    self.navigateToMain()
                case .navigateToLogin:
                    self.navigateToLogin()
                case .navigateToOnboarding:
                    self.navigateToOnboarding()
            }
        }
    }
    
    func navigateToOnboarding() {
        let vc = OnboardingViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func navigateToLogin() {
        let vc = AuthenticationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func navigateToMain() {
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
