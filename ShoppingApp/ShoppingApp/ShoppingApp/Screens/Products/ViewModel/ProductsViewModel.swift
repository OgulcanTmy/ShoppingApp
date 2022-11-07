//
//  ProductsViewModel.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import Foundation
import Alamofire

enum ProductsStateChange {
    case fetchFailure(error: String?)
    case fetchSuccess
}

class ProductsViewModel {

    var products = [ProductModel]()
    var changeHandler: ((ProductsStateChange) -> Void)?

    func fetchProducts() {
        AF.request(APIConstants.baseURL + "products").validate().responseDecodable(of: [ProductModel].self) { (response) in
            guard let products = response.value else {
                self.changeHandler?(.fetchFailure(error: response.error?.localizedDescription))
                return
            }
            self.products = products
            self.changeHandler?(.fetchSuccess)
        }
    }

}
