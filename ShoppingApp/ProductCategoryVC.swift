//
//  ProductCategoryVC.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import UIKit

class ProductCategoryVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    var categoryProducts: CategoriesProduct?
    
    var mainVC: UIViewController?
    
    // MARK: - Properties
    
    var categoryName = ""
    var parentContorller: HomeViewController!

    // MARK: - View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initialConfig()
    }
    
    // MARK: - Helper Functions
    
    static func productCategoryVC() -> ProductCategoryVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier: "ProductCategoryVC") as! ProductCategoryVC
        return vc
    }
    
    // Initial Config
    func initialConfig() {
        self.registerCell()
        self.categoriesProductApi(category: self.categoryName)
    }
    
    // Register Cell
    func registerCell() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: ProductTVCell.xibName, bundle: nil), forCellReuseIdentifier: ProductTVCell.cellIdentifier)
    }

}

// MARK: - Extensions

// MARK: API Services
extension ProductCategoryVC {
    
    // Faqs Api
    func categoriesProductApi(category: String) {
        showLoading()
        APIHelper.categoriesProductApi(category: category) { (success, response)  in
            if !success {
                dissmissLoader()
                self.view.makeToast("Something went wrong")
            } else {
                dissmissLoader()
                print(response)
                self.categoryProducts = CategoriesProduct.init(json: response.data)
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: TableView Setup
extension ProductCategoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryProducts?.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ProductTVCell.cellIdentifier, for: indexPath) as! ProductTVCell
        let product = self.categoryProducts?.products?[indexPath.item]
        cell.titleLabel.text = product?.title
        cell.brandLabel.text = product?.brand
        cell.imagesArray = product?.images ?? []
        cell.dotPageControl.numberOfPages = (product?.images ?? []).count
        cell.collectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailViewController") as! ProductDetailViewController
        productDetailVC.productDetail = self.categoryProducts?.products?[indexPath.item]
        mainVC?.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
}
