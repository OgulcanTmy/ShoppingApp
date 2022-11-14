//
//  OnboardingCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    static let identifier = "OnboardingCollectionViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setCell(with model: OnboardingModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        imageView.image = UIImage(named: model.image)
    }
    
}
