//
//  WMDetailTableViewCell.swift
//  WalmartLabTest
//
//  Created by Taranjit Lottey on 12/17/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

// *************************************************************************************************
// MARK: Imports

import UIKit

// *************************************************************************************************
// MARK: Class

class WMDetailTableViewCell: UITableViewCell {

    // *********************************************************************************************
    // MARK: IBOutlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var title: UITextView!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ratingCount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stockStatus: UILabel!
    @IBOutlet weak var shortDescription: UITextView!
    @IBOutlet weak var longDescription: UITextView!
    
    // *********************************************************************************************
    // MARK: Public Properties
    

    
    
    // *********************************************************************************************
    // MARK: View Overrides
    
    override func awakeFromNib() {

        super.awakeFromNib()
    }

}
