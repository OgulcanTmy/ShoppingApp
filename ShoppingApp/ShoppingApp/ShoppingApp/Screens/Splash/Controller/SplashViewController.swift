//
//  SplashViewController.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let viewModel = SplashViewModel()
    private let tabBarConstants = Constants.TabBar.self

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }
    
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
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToLogin() {
        let vc = AuthenticationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMain() {
        let productsViewController = ProductsViewController()
        let searchViewController = SearchViewController()
        let profileViewController = ProfileViewController()

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [productsViewController,
                                            searchViewController,
                                            profileViewController]
        tabBarController.tabBar.tintColor = .black
        tabBarController.viewControllers?[0].tabBarItem.title = tabBarConstants.products
        tabBarController.viewControllers?[0].tabBarItem.image = UIImage(named: tabBarConstants.productsIcon)
        tabBarController.viewControllers?[1].tabBarItem.title = tabBarConstants.search
        tabBarController.viewControllers?[1].tabBarItem.image = UIImage(named: tabBarConstants.searchIcon)
        tabBarController.viewControllers?[2].tabBarItem.title = tabBarConstants.profile
        tabBarController.viewControllers?[2].tabBarItem.image = UIImage(named: tabBarConstants.profileIcon)
        navigationController?.pushViewController(tabBarController, animated: true)
    }
}
