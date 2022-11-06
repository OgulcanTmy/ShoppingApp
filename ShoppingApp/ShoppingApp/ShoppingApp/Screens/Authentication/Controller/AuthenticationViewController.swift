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
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
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
