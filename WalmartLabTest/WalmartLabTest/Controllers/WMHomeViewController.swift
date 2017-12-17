//
//  ViewController.swift
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

class WMHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // *********************************************************************************************
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // *********************************************************************************************
    // MARK: Private Properties
    
    fileprivate var allProducts = [WMProductModel]()
    
    // *********************************************************************************************
    // MARK: View Controllers Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect())
        loadNextData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // *********************************************************************************************
    // MARK: TableView DataSource and Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCellIdentifier", for: indexPath)
        if let cell = cell as? WMHomeTableViewCell {
            _configureProductCell(cell, forRow: indexPath.row)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 97.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // *********************************************************************************************
    // MARK: Private Methods
    
    fileprivate func _configureProductCell(_ cell: WMHomeTableViewCell, forRow row: Int) {
       cell.product = allProducts[row]
    }
    
    fileprivate func loadNextData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WMProductManager.shared.getNextProductList { (data, error) in
            if error != nil {
                // Show alert Error
            }
            if let data = data, data.count > 0 {
                self.allProducts = data
                self.tableView.reloadData()
            }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
}

