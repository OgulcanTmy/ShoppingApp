//
//  UIView+Extensions.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 7.11.2022.
//

import UIKit

extension UIView {
    func addBlackGradientLayer(){
        let colors: [UIColor] = [.clear, .black]
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        layer.addSublayer(gradient)
    }
}
