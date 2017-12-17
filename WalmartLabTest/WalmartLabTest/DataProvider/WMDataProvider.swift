//
//  WMDataProvider.swift
//  WalmartLabTest
//
//  Created by Taranjit Lottey on 12/16/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

// *************************************************************************************************
// MARK: Imports

import UIKit

// *************************************************************************************************
// MARK: Class Definition

class WMDataProvider: NSObject {

    // *********************************************************************************************
    // MARK: Shared Instance
    
    @objc public static let shared = WMDataProvider()
    
    // *********************************************************************************************
    // MARK:  Private Properties
    
    fileprivate let apiKey = "97f633a0-7d0a-4026-abf7-fb66d5b887ad"
    fileprivate let baseURL = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1"
    fileprivate let processingQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
    fileprivate let mainQueue = DispatchQueue.main
    
    
    // *********************************************************************************************
    // MARK: Public Methods
    
    func getProductDataForPage(_ pageNo: Int, pageSize: Int,
                               completion: @escaping (_ results: [String: Any]?, _ error : NSError?) -> Void) {
        /*
         Checking the URL and all corner cases
         */
        
        guard let searchURL = productURL(pageNo, pageSize) else {
            let APIError = errorWithDiscription("Unknown API response", 0)
            completion(nil, APIError)
            return
        }
        
        let searchRequest = URLRequest(url: searchURL)
        
        URLSession.shared.dataTask(with: searchRequest, completionHandler: { (data, response, error) in
            self.processingQueue.async {
                if let error = error {
                    let APIError = self.errorWithDiscription(error.localizedDescription, 0)
                    self.mainQueue.async {
                        completion(nil, APIError)
                    }
                    return
                }
                
                guard let _ = response as? HTTPURLResponse,
                    let data = data else {
                        let APIError = self.errorWithDiscription("Unknown API response", 0)
                        self.mainQueue.async {
                            completion(nil, APIError)
                        }
                        return
                }
                
                do {
                    
                    guard var resultsDictionary = try JSONSerialization.jsonObject(with: data,
                                                                                   options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] else {
                        
                        let APIError = self.errorWithDiscription("Invalid Response", 0)
                        self.mainQueue.async {
                            completion(nil, APIError)
                        }
                        return
                    }
                    
                    if let prodList = resultsDictionary["products"] as? Array<Dictionary<String, AnyObject>> {
                        let allProducts = WMProductModelParserUtil.parseProductData(jsonArray: prodList)
                        if allProducts.count == 0 {
                            let APIError = self.errorWithDiscription("Unable to parse response", 0)
                            self.mainQueue.async {
                                completion(nil, APIError)
                            }
                        } else {
                            self.mainQueue.async {
                                var result = [String: Any]()
                                result["products"] = allProducts
                                result["totalProducts"] = resultsDictionary["totalProducts"]
                                result["pageNumber"] = resultsDictionary["pageNumber"]
                                result["pageSize"] = resultsDictionary["pageSize"]
                                completion(result, nil)
                            }
                        }
                    }
                    
                } catch _ {
                    let APIError = self.errorWithDiscription("Unknown API response", 0)
                    self.mainQueue.async {
                        completion(nil, APIError)
                    }

                    return
                }
            }
        }).resume()
    }
    
    // ****************************************************************************************
    // MARK:  Private Methods
    
    fileprivate func productURL(_ pageNo: Int, _ pageSize: Int) -> URL? {
        let urlString = "\(baseURL)/walmartproducts/\(apiKey)/\(pageNo)/\(pageSize)"
        
        guard let url_ = URL(string: urlString) else {
            return nil
        }
        
        return url_
    }
    
    fileprivate func errorWithDiscription(_ description: String, _ code: Int) -> NSError {
        let err = NSError(domain: "WMError",
                          code: code,
                          userInfo: [NSLocalizedFailureReasonErrorKey:description])
        
        return err
    }
    
}
