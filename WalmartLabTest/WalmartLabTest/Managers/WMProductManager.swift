//
//  WMProductManager.swift
//  WalmartLabTest
//
//  Created by Taranjit Lottey on 12/16/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

// *************************************************************************************************
// # MARK: - Imports

import UIKit

// *************************************************************************************************
// # MARK: - Class Definition

class WMProductManager: NSObject {
    
    // *********************************************************************************************
    // # MARK: - Private init
    
    fileprivate override init() {
        // Default initialiser
    }
    
    // *************************************************************************************************
    // # MARK: - Shared Instance
    
    public static let shared = WMProductManager()

    // *************************************************************************************************
    // # MARK: - Private Property
    
    fileprivate var allProducts = [WMProductModel]()
    fileprivate var currentPage = 0
    fileprivate let pageSize = 30
    
    // *************************************************************************************************
    // # MARK: - Public Methods
    
    func getNextItemFrom(item: WMProductModel) -> WMProductModel? {
        if let index = allProducts.index(of: item), index + 1 < allProducts.count {
            return allProducts[index + 1]
        }
        
        return nil
    }
    
    
    func getNextProductList(completion: @escaping (_ results: [WMProductModel]?, _ error : NSError?) -> Void) {
        currentPage += 1
        WMDataProvider.shared.getProductDataForPage(currentPage, pageSize: pageSize) { (results, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            guard let results = results,
                  let products = results["products"] as? [WMProductModel] else {
                return
            }
            self.allProducts.append(contentsOf: products)
            completion(self.allProducts, nil)
        }
    }
    
    func getPreviousItemFrom(item: WMProductModel) -> WMProductModel? {
        if let index = allProducts.index(of: item), index - 1 > 0 {
            return allProducts[index - 1]
        }
        
        return nil
    }
    
}
