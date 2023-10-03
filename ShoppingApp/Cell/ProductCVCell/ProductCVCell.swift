//
//  ProductCVCell.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import UIKit

class ProductCVCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    static let xibName = "ProductCVCell"
    static let cellIdentifier = "ProductCVCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
