//
//  AuthenticationViewModel.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum AuthenticationStateChange {
    case authSuccess
    case authFailure(_ error: String)
}

enum AuthType {
    case login
    case register
}

class AuthenticationViewModel {
    var changeHandler: ((AuthenticationStateChange) -> Void)?
    var authType: AuthType = .login
    private let defaults = UserDefaults.standard
    private let db = Firestore.firestore()

    func auth(with model: UserRequestModel) {
        switch authType {
            case .login:
                Auth.auth().signIn(withEmail: model.email, password: model.password) { [weak self] authResult, error in
                    guard let self = self else { return }
                    if let error = error {
                        self.changeHandler?(.authFailure(error.localizedDescription))
                        return
                    }

                    guard let id = authResult?.user.uid else {
                        return
                    }

                    self.defaults.set(id, forKey: "uid")
                    self.changeHandler?(.authSuccess)
                }
            case .register:
                Auth.auth().createUser(withEmail: model.email, password: model.password) { [weak self] result, error in
                    guard let self = self else { return }
                    if let error = error {
                        self.changeHandler?(.authFailure(error.localizedDescription))
                        return
                    }

                    let user = UserResponseModel(username: result?.user.displayName, email: result?.user.email, uid: result?.user.uid ?? "")

                    do {
                        guard let data = try user.dictionary,
                              let id = result?.user.uid else {
                            return
                        }

                        self.defaults.set(id, forKey: Constants.Defaults.uid)

                        self.db.collection(Constants.Authentication.users).document(id).setData(data) { error in

                            if let error = error {
                                self.changeHandler?(.authFailure(error.localizedDescription))
                            } else {
                                self.changeHandler?(.authSuccess)
                            }
                        }
                    } catch {
                        self.changeHandler?(.authFailure(error.localizedDescription))
                    }
                }
        }
    }
}
