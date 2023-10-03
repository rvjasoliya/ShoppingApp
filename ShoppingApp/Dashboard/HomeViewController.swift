//
//  HomeViewController.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var container: UIView!
    
    // MARK: - Properties
    
    var categories: [String] = []
    var selectedIndex = 0
    var pageMenu: CAPSPageMenu!
    var controllerArray: [UIViewController] = []
    
    // MARK: - View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        self.initialConfig()
    }
    
    // MARK: - Helper Functions
    
    // Initial Config
    func initialConfig() {
        self.registerCell()
        self.categoriesApi()
    }
    
    // Register Cell
    func registerCell() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: CategoryCell.xibName, bundle: nil), forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
    }

}

// MARK: API Services
extension HomeViewController {
    
    // Faqs Api
    func categoriesApi() {
        showLoading()
        APIHelper.categoriesApi() { (success, response)  in
            if !success {
                dissmissLoader()
                self.view.makeToast("Something went wrong")
            } else {
                dissmissLoader()
                if let data = response.data.arrayObject as? [String] {
                    self.categories = data
                    for category in self.categories {
                        let productCategoryVC: ProductCategoryVC = ProductCategoryVC.productCategoryVC()
                        productCategoryVC.categoryName = category
                        productCategoryVC.parentContorller = self
                        productCategoryVC.mainVC = self
                        self.controllerArray.append(productCategoryVC)
                    }
                    let parameters: [CAPSPageMenuOption] = [
                        .menuHeight(00)
                    ]
                    self.pageMenu = CAPSPageMenu(viewControllers: self.controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.container.bounds.width, height: self.container.bounds.height), pageMenuOptions: parameters)
                    self.pageMenu.delegate = self
                    self.container.addSubview(self.pageMenu.view!)
                    self.pageMenu.moveToPage(0)
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}

// MARK: - Extensions

// MARK: Collection View Setup
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as! CategoryCell
        cell.titleLabel.text = self.categories[indexPath.row]
        if self.selectedIndex == indexPath.row {
            cell.titleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
            cell.titleLabel.textColor = UIColor(named: "Brandeis Blue")
            cell.bottomBorder.backgroundColor = UIColor(named: "Brandeis Blue")
        } else {
            cell.titleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
            cell.titleLabel.textColor = UIColor(named: "AuroMetalSaurus")
            cell.bottomBorder.backgroundColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.pageMenu.currentPageIndex != indexPath.item {
            self.pageMenu.moveToPage(indexPath.item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.selectedIndex == indexPath.row {
            return CGSize(width: getWidthFromItem(title: self.categories[indexPath.row], font: UIFont.systemFont(ofSize: 18.0, weight: .semibold)).width + 25, height: 48)
        } else {
            return CGSize(width: getWidthFromItem(title: self.categories[indexPath.row], font: UIFont.systemFont(ofSize: 18.0, weight: .regular)).width + 25, height: 48)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    // Get Width From String
    func getWidthFromItem(title: String, font: UIFont) -> CGSize {
        let itemSize = title.size(withAttributes: [
            NSAttributedString.Key.font: font
        ])
        return itemSize
    }
    
}

// MARK: CAPSPageMenuDelegate
extension HomeViewController: CAPSPageMenuDelegate {
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        self.selectedIndex = index
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionView.reloadData()
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        self.selectedIndex = index
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionView.reloadData()
    }
    
}
