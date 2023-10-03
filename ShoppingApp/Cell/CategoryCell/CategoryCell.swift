//
//  CategoryCell.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomBorder: UIView!
    @IBOutlet weak var borderHeight: NSLayoutConstraint!
    
    static let xibName = "CategoryCell"
    static let reuseIdentifier = "CategoryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
