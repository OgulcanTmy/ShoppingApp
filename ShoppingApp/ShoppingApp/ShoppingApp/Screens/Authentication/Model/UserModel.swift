//
//  UserModel.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import Foundation

struct UserRequestModel {
    let email: String
    let password: String
}

struct UserResponseModel: Encodable {
    let username: String?
    let email: String?
    let uid: String?
}

extension UserResponseModel {
    init(from dict: [String: Any]) {
        username = dict["username"] as? String
        email = dict["email"] as? String
        uid = dict["uid"] as? String
    }
}
