//
//  ProfileViewController.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct ProfileModel {
    let email: String
    let uid: String
}

class ProfileViewController: UIViewController {

    let defaults = UserDefaults.standard
    let constants = Constants.Defaults.self
    let db = Firestore.firestore()

    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        checkUser()
    }

    func checkUser() {
        db.collection("users").whereField("uid", isEqualTo: defaults.value(forKey: "uid") ?? true).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let model = document.data()
                    self.userNameLabel.text = (model["email"] as! String)
                    self.uidLabel.text = (model["uid"] as! String)
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        parent?.title = "Profil"
        parent?.navigationItem.rightBarButtonItem = nil
    }

    @IBAction func tappedQuit(_ sender: Any) {
        showAlert(title: "Uyarı!", message: "Çıkış yapıyorsun", cancelButtonTitle: "Geri Dön") { _ in
            do {
                try Auth.auth().signOut()
                self.defaults.set(nil, forKey: self.constants.isLoggedIn)
                self.parent?.navigationController?.setViewControllers([AuthenticationViewController()], animated: true)
            } catch {
                print("cant logout")
            }
        }
    }
}
