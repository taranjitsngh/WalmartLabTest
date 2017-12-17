//
//  WMHomeTableViewCell.swift
//  WalmartLabTest
//
//  Created by Taranjit Lottey on 12/16/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//


// *************************************************************************************************
// MARK: Imports

import UIKit

// *************************************************************************************************
// MARK: Class

class WMHomeTableViewCell: UITableViewCell {

    // *************************************************************************************************
    // MARK: IBOutlets
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ratingCount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stockStatus: UILabel!
    
    // *************************************************************************************************
    // MARK: Public Properties
    
    var product: WMProductModel? {
        
        didSet {
            
            if let product = product {
                title.text = NSLocalizedString(product.productName, comment: "")
                ratingView.rating = product.reviewRating!
                rating.text = String(format: "%.1f", product.reviewRating!)
                ratingCount.text = String(format: "(%d)", product.reviewCount!)
                price.text = product.price
                stockStatus.text = product.stockStatus()
                if product.inStock {
                    stockStatus.textColor = UIColor.inStockGreenColor
                } else {
                    stockStatus.textColor = UIColor.outOfStockRedColor
                }
            }
        }
    }
    
    // *************************************************************************************************
    // MARK: View Controller Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
