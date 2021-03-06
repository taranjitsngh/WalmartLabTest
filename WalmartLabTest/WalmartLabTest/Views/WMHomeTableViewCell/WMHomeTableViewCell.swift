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
                // SD WebImageView extentions take care of image caching
                icon.sd_setImage(with: URL(string: product.productImageUrl ?? ""),
                                 placeholderImage: UIImage(named: "Placeholder.jpeg"))
                title.text = product.productName
                ratingView.rating = product.reviewRating!
                rating.text = product.ratingText()
                ratingCount.text = product.reviewCountText()
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
    // MARK: View Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
