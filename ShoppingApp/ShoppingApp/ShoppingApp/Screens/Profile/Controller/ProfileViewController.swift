//
//  ProfileViewController.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        parent?.title = "Profil"
        parent?.navigationItem.rightBarButtonItem = nil
    }

}
