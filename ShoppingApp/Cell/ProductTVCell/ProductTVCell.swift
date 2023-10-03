//
//  ProductTVCell.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import UIKit
import SDWebImage

class ProductTVCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var dotPageControl: UIPageControl!
    
    static let xibName = "ProductTVCell"
    static let cellIdentifier = "ProductTVCell"
    
    var imagesArray: [String] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.initialConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Helper Functions
    
    // Initial Config
    func initialConfig() {
        self.registerCell()
        self.dotPageControl.numberOfPages = self.imagesArray.count
    }
    
    // Register Cell
    func registerCell() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionViewHeight.constant = (UIScreen.main.bounds.width * 280) / 400
        self.collectionView.register(UINib(nibName: ProductCVCell.xibName, bundle: nil), forCellWithReuseIdentifier: ProductCVCell.cellIdentifier)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView {
            let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
            let yPoint = scrollView.frame.height / 2
            let center = CGPoint(x: xPoint, y: yPoint)
            if let ip = self.collectionView.indexPathForItem(at: center) {
                self.dotPageControl.currentPage = ip.row
            }
        }
    }
    
}

// MARK: Collection View Setup
extension ProductTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCVCell.cellIdentifier, for: indexPath) as! ProductCVCell
        let imageUrl = URL(string: self.imagesArray[indexPath.item])
        let indicator = SDWebImageActivityIndicator.medium
        cell.productImage.sd_imageIndicator = indicator
        DispatchQueue.global(qos: .userInteractive).async {
            cell.productImage.sd_setImage(with: imageUrl , placeholderImage: UIImage(named: ""))
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
