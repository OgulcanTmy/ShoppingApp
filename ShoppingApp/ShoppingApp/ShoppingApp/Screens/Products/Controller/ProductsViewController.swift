//
//  ProductsViewController.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit

class ProductsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    private let viewModel = ProductsViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        parent?.title = "Ürünler"
        parent?.navigationController?.navigationBar.isHidden = false
        parent?.navigationItem.setHidesBackButton(true, animated: false)
        let item = UIBarButtonItem(image: UIImage(named: Constants.cart)?.withRenderingMode(.alwaysOriginal),
                                   style: .plain,
                                   target: self,
                                   action: #selector(tappedBasketButton))
        parent?.navigationItem.rightBarButtonItem = item
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            UINib(nibName: ProductsCollectionViewCell.identifier,
                  bundle: Bundle.main),
            forCellWithReuseIdentifier: ProductsCollectionViewCell.identifier
        )
        viewModel.fetchProducts()

        viewModel.changeHandler = { state in
            switch state {
                case .fetchFailure(error: let error):
                    self.showError(error ?? "")
                case .fetchSuccess:
                    self.collectionView.reloadData()
            }
        }
    }

    @objc func tappedBasketButton() {
        let vc = BasketViewController()
        present(vc, animated: true)
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.identifier, for: indexPath) as! ProductsCollectionViewCell
        cell.setCell(with: viewModel.products[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 48)/2, height: (collectionView.frame.width + 48)/2)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailViewController()
        vc.model = viewModel.products[indexPath.item]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
