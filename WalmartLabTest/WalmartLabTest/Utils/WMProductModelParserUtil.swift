//
//  WMProductModelParserUtil.swift
//  WalmartLabTest
//
//  Created by Taranjit Lottey on 12/16/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

// *********************************************************************************************
// # MARK: Imports

import UIKit

// *********************************************************************************************
// # MARK: Class

class WMProductModelParserUtil: NSObject {

    public static func parseProductData(jsonArray: Array<Dictionary<String, AnyObject>>) -> [WMProductModel] {
        var allProducts = [WMProductModel]()
        for eachProduct in jsonArray {
            let product = WMProductModel.init(json: eachProduct)
            if let product = product {
                allProducts.append(product)
            }
        }
        
        return allProducts
    }
}
