//
//  BasketTableViewCell.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit

protocol BasketTableViewCellDelegate: AnyObject {
    func updateBasket(with row: Int?, count: Int)
}

class BasketTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!

    static let identifier = "BasketTableViewCell"

    weak var delegate: BasketTableViewCellDelegate?
    var indexRow: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(with model: ProductModel?) {
        stepper.value = Double((model?.basketCount)!)
        countLabel.text = "\(model?.basketCount ?? 0)"
        nameLabel.text = model?.title
    }

    @IBAction func stepperTapped(_ sender: UIStepper) {
        let count = Int(sender.value)
        countLabel.text = count.description
        delegate?.updateBasket(with: indexRow, count: count)
    }

}
