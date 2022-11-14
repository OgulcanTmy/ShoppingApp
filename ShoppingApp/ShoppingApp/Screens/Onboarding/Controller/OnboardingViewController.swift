//
//  OnboardingViewController.swift
//  ShoppingApp
//
//  Created by Oğulcan Tamyürek on 6.11.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private let viewModel = OnboardingViewModel()
    private let constants = Constants.Onboarding.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = viewModel.pageModel.count
        pageControl.currentPage = 0

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            UINib(nibName: OnboardingCollectionViewCell.identifier,
                  bundle: Bundle.main),
            forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier
        )
    }
    
    func changePage(to pageNumber: Int) {
        if pageNumber == 0 {
            nextButton.titleLabel?.text = constants.next
            previousButton.isHidden = true
            skipButton.isHidden = false
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.nextButton.titleLabel?.text = self.constants.start
            })
            previousButton.isHidden = false
            skipButton.isHidden = true
        }
        collectionView.scrollToItem(
            at: IndexPath(item: pageNumber, section: 0),
            at: .centeredHorizontally, animated: true
        )
        pageControl.currentPage = pageNumber
        viewModel.pageNumber = pageNumber
    }
    
    func navigateToLogin() {
        UserDefaults.standard.set(true, forKey: Constants.Defaults.isPassedOnboarding)
        let vc = AuthenticationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tappedSkipButton(_ sender: Any) {
        navigateToLogin()
    }

    @IBAction func tappedPreviousButton(_ sender: Any) {
        changePage(to: 0)
    }
    
    @IBAction func tappedNextButton(_ sender: Any) {
        if viewModel.pageNumber == 0 {
            changePage(to: 1)
        } else {
            navigateToLogin()
        }
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pageModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setCell(with: viewModel.pageModel[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        changePage(to: Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))
    }
}
