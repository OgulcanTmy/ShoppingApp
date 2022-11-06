//
//  UIViewController+Extensions.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit

extension UIViewController {
    func showAlert(title: String? = nil,
                   message: String? = nil,
                   cancelButtonTitle: String? = nil,
                   handler: ((UIAlertAction) -> Void)? = nil ) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: handler)

        if let cancelButtonTitle = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: cancelButtonTitle,
                                             style: .cancel)
            alertController.addAction(cancelAction)
        }

        alertController.addAction(defaultAction)
        self.present(alertController, animated: true)
    }

    func showError(_ error: String) {
        showAlert(title: "Hata!",
                  message: error)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
