//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 7.11.2022.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addCartButton: UIButton! {
        didSet {
            addCartButton.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var stepperCountLabel: UILabel!

    var model: ProductModel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addCartButton.isUserInteractionEnabled = false
        setVC(with: model!)
    }

    func setVC(with model: ProductModel) {
        title = "Ürün Detay"
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        priceLabel.text = "Fiyat: \(model.price ?? 0)₺"
        rateLabel.text = "Değerlendirme: \(model.rating?.rate ?? 0)"
        let url = URL(string: model.image ?? "")
        imageView.kf.setImage(with: url)
    }


    @IBAction func tappedStepper(_ sender: UIStepper) {
        let count = Int(sender.value)
        if count == 0 {
            addCartButton.isUserInteractionEnabled = false
            addCartButton.isEnabled = false
        } else {
            addCartButton.isUserInteractionEnabled = true
            addCartButton.isEnabled = true
        }
        stepperCountLabel.text = count.description
    }

    @IBAction func tappedAddCartButton(_ sender: Any) {
        let count = Int(stepperCountLabel.text ?? "0")
        let basketItem = ProductModel(id: model?.id, title: model?.title, price: (model?.price ?? 0), description: model?.description, category: model?.category, image: model?.image, rating: model?.rating, basketCount: count)
        if var basketItems: [ProductModel] = UserDefaults.standard.retrieveCodable(for: Constants.Defaults.basketItems) {
            basketItems.append(basketItem)
            UserDefaults.standard.storeCodable(basketItems, key: Constants.Defaults.basketItems)
        } else {
            UserDefaults.standard.storeCodable([basketItem], key: Constants.Defaults.basketItems)
        }
        showAlert(title: "Ürünler Sepete Eklendi", message: "Alışverişe Devam Edebilirsiniz", cancelButtonTitle: nil, handler: nil)
    }


}
