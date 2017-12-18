//
//  WMDetailViewController.swift
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

class WMDetailViewController: UIViewController {

    // *************************************************************************************************
    // # MARK: - Public Property
    
    var product: WMProductModel? {
        
        didSet {
            if let product = product {
                showAlert(product.productName)
            }
        }
    }
    
    
    // *************************************************************************************************
    // # MARK: - IBActions
    
    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
        if let product = product,
            let nextProd = WMProductManager.shared.getPreviousItemFrom(item: product) {
            self.product = nextProd
        } else {
            showAlert("No more products")
        }
    }
    
    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        if let product = product,
            let nextProd = WMProductManager.shared.getNextItemFrom(item: product) {
            self.product = nextProd
        } else {
            showAlert("No more products")
        }
    }
    
    // *************************************************************************************************
    // # MARK: - View Controller Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    // *************************************************************************************************
    // # MARK: - Private Methods
    
    fileprivate func showAlert(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .text
        hud.label.text = NSLocalizedString(message, comment: "")
        hud.offset = CGPoint.init(x: 0.0, y: MBProgressMaxOffset) 
        hud.hide(animated: true, afterDelay: 0.3)
    }
    
}
