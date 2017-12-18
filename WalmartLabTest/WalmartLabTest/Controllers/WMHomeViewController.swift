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
    // MARK: Constants
    
    fileprivate let productDetailSegueIdentifier = "ProductDetailVCSegue"
    fileprivate let tableCellRowHeight: CGFloat = 97.0
    
    // *********************************************************************************************
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // *********************************************************************************************
    // MARK: Private Properties
    
    fileprivate var allProducts = [WMProductModel]()
    fileprivate var selectedRow = 0
    
    
    // *********************************************************************************************
    // MARK: View Controllers Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {
            self.loadNextData()
        })
        loadNextData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // *********************************************************************************************
    // MARK: TableView DataSource and Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = allProducts.count == 0
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
        
        return tableCellRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
    }
    
    // *********************************************************************************************
    // MARK: Segue
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
              let cell = sender as? WMHomeTableViewCell else { return }
    
        if identifier == productDetailSegueIdentifier {
            guard let controller = segue.destination as? WMDetailViewController else { return }
            controller.product = cell.product
        }
    }
    
    // *********************************************************************************************
    // MARK: Private Methods
    
    fileprivate func _configureProductCell(_ cell: WMHomeTableViewCell, forRow row: Int) {
       cell.product = allProducts[row]
    }
    
    fileprivate func loadNextData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WMProductManager.shared.getNextProductList { (data, error) in
            self.tableView.mj_footer.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
            if error != nil {
                self.showAlert(error?.localizedDescription ?? "Failure")
                return
            }
            if let data = data, data.count > 0 {
                self.allProducts = data
                self.tableView.reloadData() // Will not reload the whole table, just load the new rows
                
            }
        }
    }
    
    fileprivate func showAlert(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .text
        hud.label.text = NSLocalizedString(message, comment: "")
        hud.offset = CGPoint(x: 0.0, y: MBProgressMaxOffset)
        hud.hide(animated: true, afterDelay: 0.5)
    }
    
}

