//
//  ProductsCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit
import Kingfisher

class ProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var priceLabel: UILabel!
    static let identifier = "ProductsCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        imageView.addBlackGradientLayer()
    }

    func setCell(with model: ProductModel) {
        nameLabel.text = model.title
        priceLabel.text = "\(model.price ?? 0)₺"
        let url = URL(string: model.image ?? "")
        imageView.kf.setImage(with: url)
        bringSubviewToFront(infoStackView)
    }

}
