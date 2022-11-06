//
//  AuthenticationViewController.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit

class AuthenticationViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.keyboardType = .emailAddress
            emailTextField.autocorrectionType = .no
            emailTextField.autocapitalizationType = .none
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var confirmButton: UIButton! {
        didSet {
            confirmButton.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var changeAuthType: UIButton!

    private let viewModel = AuthenticationViewModel()
    private let constants = Constants.Authentication.self
    private let tabBarConstants = Constants.TabBar.self

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()

        viewModel.changeHandler = { state in
            switch state {
                case .authSuccess:
                    self.navigateToMain()
                case .authFailure(let error):
                    self.showError(error)
            }
        }
    }

    private func navigateToMain() {
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

    @IBAction func tappedConfirmButton(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            showAlert(title: "Eksik Bilgi", message: "Bilgilerinizi kontrol edin.", cancelButtonTitle: "Tamam", handler: nil)
            return
        }
        viewModel.auth(with: UserRequestModel(email: email, password: password))
    }

    @IBAction func tappedChangeAuthButton(_ sender: Any) {
        if viewModel.authType == .login {
            viewModel.authType = .register
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.1) {
                self.titleLabel.text = self.constants.register
                self.confirmButton.setTitle(self.constants.register, for: .normal)
                self.changeAuthType.setTitle(self.constants.haveAccount, for: .normal)
            }
        } else {
            viewModel.authType = .login
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.1) {
                self.titleLabel.text = self.constants.login
                self.confirmButton.setTitle(self.constants.login, for: .normal)
                self.changeAuthType.setTitle(self.constants.dontHaveAccount, for: .normal)
            }
        }
    }


}
