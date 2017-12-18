//
//  WMProductModel.swift
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

class WMProductModel: NSObject {

    var productId: String!
    var productName: String!
    var shortDescription: String?
    var longDescription: String?
    var price: String!
    var productImageUrl: String?
    var reviewRating: Double?
    var reviewCount: Int?
    var inStock: Bool!
    
    // **********************************************************************************************
    // MARK: Initializers
    
    private override init() {
        productId = ""
        productName = ""
        shortDescription = ""
        longDescription = ""
        price = ""
        productImageUrl = ""
        reviewRating = 0.0
        reviewCount = 0
        inStock = false
        
        super.init()
    }
    
    public required init?(json: Dictionary<String, AnyObject>) {
        
        guard let productId = json["productId"] as? String,
              let productName = json["productName"] as? String,
              let price = json["price"] as? String,
              let inStock = json["inStock"] as? Bool else {
            
            return nil
        }
        let shortDescription = json["shortDescription"] as? String ?? ""
        let longDescription = json["longDescription"] as? String ?? ""
        let productImage = json["productImage"] as? String ?? ""
        let reviewRating = json["reviewRating"] as? Double ?? 0.0
        let reviewCount = json["reviewCount"] as? Int ?? 0
        
        self.productId = productId
        self.productName = productName
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.price = price
        self.productImageUrl = productImage
        self.reviewRating = reviewRating
        self.reviewCount = reviewCount
        self.inStock = inStock
        
        super.init()
    }
    
}

extension WMProductModel {
    
    func stockStatus() -> String {
        if inStock {
            return NSLocalizedString("In stock", comment: "")
        } else {
            return NSLocalizedString("Not in stock", comment: "")
        }
    }
    
    func attributedStortDiscription() -> NSAttributedString {
        let htmlData = shortDescription!.data(using: String.Encoding(rawValue: String.Encoding.unicode.rawValue))
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        
        return attributedString
    }
    
    func attributedLongDescription() -> NSAttributedString {
        let htmlData = longDescription!.data(using: String.Encoding(rawValue: String.Encoding.unicode.rawValue))
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        
        return attributedString
    }
    
    func ratingText() -> String {
        
       return String(format: "%.1f", reviewRating!)
        
    }
    
    func reviewCountText() -> String {
        
        return String(format: "(%d)", reviewCount!)
    }
    
}

