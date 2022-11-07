//
//  ProductsModel.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 7.11.2022.
//

import Foundation

struct ProductModel: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
    var basketCount: Int? = nil
}

struct Rating: Codable {
    let rate: Double?
    let count: Int?
}
