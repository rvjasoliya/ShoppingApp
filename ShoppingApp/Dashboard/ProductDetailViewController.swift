//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import UIKit
import FSPagerView

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var pageControl:UIPageControl!
    @IBOutlet weak var sliderView: FSPagerView! {
        didSet {
            self.sliderView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    
    var productDetail: Products?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = productDetail?.title
        brandLabel.text = "\(productDetail?.brand ?? "") \(productDetail?.category ?? "")"
        ratingLabel.text =  "Rating \(productDetail?.rating ?? 0.0)"
        stockLabel.text = "Stock \(productDetail?.stock ?? 0)"
        priceLabel.text = "$\(productDetail?.price ?? 0)"
        discountLabel.text = "$\(productDetail?.discountPercentage ?? 0.0)%"
        descLabel.text = productDetail?.description
        setSider()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
    // Image Slider SetUp
    func setSider() {
        sliderView.delegate = self
        sliderView.dataSource = self
        sliderView.isInfinite = false
        sliderView.automaticSlidingInterval = 5.0
        sliderView.interitemSpacing = 0
        pageControl.numberOfPages = 4
        pageControl.currentPage = 1
        sliderView.transformer = FSPagerViewTransformer(type: .linear)
        sliderView.itemSize = CGSize(width: sliderView.frame.width - 5, height: sliderView.frame.height - 5)
        //         if (DeviceType.IS_IPHONE_5) {
        //             imagePagerView.itemSize = CGSize(width: imagePagerView.frame.width - 100, height: imagePagerView.frame.height - 70)
        //         }
        
        pageControl.numberOfPages = productDetail?.images?.count ?? 0
        pageControl.currentPage = 0
        pageControl.contentHorizontalAlignment = .right
    }
    

}


//MARK: FSPagerView Delegate And DataSource Methods
extension ProductDetailViewController: FSPagerViewDelegate, FSPagerViewDataSource{
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return productDetail?.images?.count ?? 0
    }
        
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = sliderView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.sd_setImage(with: URL(string: productDetail?.images?[index] ?? ""), completed: nil)
        cell.imageView?.cornerRadius = 15
        cell.imageView?.clipsToBounds = true
        cell.imageView?.contentMode = .center
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
}
