//
//  BasketViewController.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit
import SnapKit

class BasketViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var butButton: UIButton! {
        didSet {
            butButton.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var bottomContainer: UIView!
    var model: [ProductModel]? {
        didSet {
            tableView.reloadData()
            calculatePrice()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: BasketTableViewCell.identifier, bundle: Bundle.main),
                           forCellReuseIdentifier: BasketTableViewCell.identifier)

        if let basketItems: [ProductModel] = UserDefaults.standard.retrieveCodable(for: Constants.Defaults.basketItems) {
            model = basketItems
            calculatePrice()
        } else {
            hideBottom()
        }
    }

    func calculatePrice() {
        if let items = model {
            var price = 0.0
            for item in items {
                price += ((item.price ?? 0) * Double(item.basketCount ?? 0))
            }
            let doubleStr = String(format: "%.2f", price)
            if doubleStr == "0.00" {
                hideBottom()
            } else {
                priceLabel.text = "\(doubleStr) ₺"
            }
        }
    }

    func hideBottom() {
        bottomContainer.isHidden = true
        let label = UILabel()
        label.text = "Sepetiniz Boş"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @IBAction func tappedBuyButton(_ sender: Any) {
        showAlert(title: "İşlem Başarılı", message: "Siparişiniz Alındı", cancelButtonTitle: nil) { _ in
            self.dismiss(animated: true)
        }
        UserDefaults.standard.set(nil, forKey: Constants.Defaults.basketItems)
    }

}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier, for: indexPath) as! BasketTableViewCell
        cell.setCell(with: model?[indexPath.row])
        cell.indexRow = indexPath.row
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

extension BasketViewController: BasketTableViewCellDelegate {
    func updateBasket(with row: Int?, count: Int) {
        if count == 0 {
            model?.remove(at: row ?? 0)
        } else {
            model?[row ?? 0].basketCount = count
        }
        if let model = model {
            UserDefaults.standard.storeCodable(model, key: Constants.Defaults.basketItems)
        }
    }
}
