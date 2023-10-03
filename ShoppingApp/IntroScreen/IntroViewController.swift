//
//  IntroViewController.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import UIKit

class IntroViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var onboardingView: OnboardingView!
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.dataSource = self
        onboardingView.delegate = self
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func skipButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let newVC = myApp.storyboard.instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
        myApp.window?.rootViewController = newVC
    }
   
}

extension IntroViewController: OnboardingViewDelegate, OnboardingViewDataSource {
    public func numberOfPages() -> Int {
        return 4
    }
    
    public func onboardingView(_ onboardingView: OnboardingView, configurationForPage page: Int) -> OnboardingConfiguration {
        switch page {
        case 0:
            return OnboardingConfiguration(
                image: UIImage(named: "1")?.resized(withPercentage: 0.3),
                itemImage: UIImage(named: "1"),
                pageTitle: "Shop all that you want",
                pageDescription: "You get a wide variety of products all just a few clicks away! Hurry get them all",
                backgroundImage: UIImage(named: "BackgroundRed"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "WavesImage")
            )
        case 1:
            return OnboardingConfiguration(
                image: UIImage(named: "2")?.resized(withPercentage: 0.3),
                itemImage: UIImage(named: "2"),
                pageTitle: "Easy shopping experience",
                pageDescription: "No hassle, just a few clicks and the product is in your house in a few days",
                backgroundImage: UIImage(named: "BackgroundBlue"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "WavesImage")
            )
        case 2:
            return OnboardingConfiguration(
                image: UIImage(named: "3")?.resized(withPercentage: 0.3),
                itemImage: UIImage(named: "3"),
                pageTitle: "Save Card Information Securely",
                pageDescription: "Easy and secure checkouts with saved cards get you going at an instance",
                backgroundImage: UIImage(named: "BackgroundOrange"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "WavesImage")
            )
        case 3:
            return OnboardingConfiguration(
                image: UIImage(named: "4")?.resized(withPercentage: 0.3),
                itemImage: UIImage(named: "4"),
                pageTitle: "Easy Checkouts",
                pageDescription: "Just choose the delivery option and we will take care of the rest",
                backgroundImage: UIImage(named: "BackgroundOrange"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "WavesImage")
            )
        default:
            fatalError("Out of range!")
        }
    }
    
    public func onboardingView(_ onboardingView: OnboardingView, configurePageView pageView: PageView, atPage page: Int) {
        pageView.titleLabel.textColor = UIColor.white
        pageView.titleLabel.numberOfLines = 2
        pageView.titleLabel.layer.shadowOpacity = 0.6
        pageView.titleLabel.layer.shadowColor = UIColor.black.cgColor
        pageView.titleLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
        pageView.titleLabel.layer.shouldRasterize = true
        pageView.titleLabel.layer.rasterizationScale = UIScreen.main.scale
    }
    
    public func onboardingView(_ onboardingView: OnboardingView, didSelectPage page: Int) {
    }
    
    public func onboardingView(_ onboardingView: OnboardingView, willSelectPage page: Int) {
        //print("Will select page \(page)")
        if page == 3 {
            self.skipButton.isHidden = true
            onboardingView.currentPageView().buttonStart.isHidden = false
            onboardingView.currentPageView().buttonStart.setTitle("Start", for: .normal)
        } else {
            onboardingView.currentPageView().buttonStart.isHidden = true
            self.skipButton.isHidden = false
        }
    }
}
