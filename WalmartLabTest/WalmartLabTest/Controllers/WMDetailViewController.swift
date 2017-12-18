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

class WMDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // *************************************************************************************************
    // # MARK: Enumerations
    
    enum CellIdentifiers: String {
        case productMainCell = "ProductMainCell"
        case productImageCell = "ProductImageCell"
        case productDetailCell = "ProductDetailCell"
    }
    
    enum SectionHeaders: String {
        case identifier = "SectionHeaderIdentifier"
    }
    
    enum SectionIdentifiers: Int {
        case productMainSection = 0
        case productImageSection
        case productDetailSection
    }

    // *********************************************************************************************
    // # MARK: - Public Property
    
    var product: WMProductModel? {
        
        didSet {
            guard let _ = product else {
                return
            }
            
            var sectionInfo: [(SectionIdentifiers, String)] = []
            sectionInfo.append((.productMainSection, ""))
            sectionInfo.append((.productImageSection, ""))
            sectionInfo.append((.productDetailSection, ""))
            tableSectionInfo = sectionInfo
        }
    }
    
    // *********************************************************************************************
    // # MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView?
    
    // *************************************************************************************************
    // # MARK: - Private Properties
    
    fileprivate var tableSectionInfo: [(SectionIdentifiers, String)]! = [] {
        
        didSet {
            if let tableView = tableView {
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                tableView.reloadData()
            }
        }
    }
    
    // *********************************************************************************************
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
    
    // *********************************************************************************************
    // # MARK: - View Controller Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.estimatedSectionFooterHeight = 0
        tableView?.sectionFooterHeight = 0
        tableView?.estimatedRowHeight = 70
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.tableFooterView = UIView(frame: CGRect())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // *********************************************************************************************
    // MARK: TableView DataSource and Delegates
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return tableSectionInfo.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.01
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellIdentifier = cellIdentifier(forSectionId: tableSectionInfo[indexPath.section].0,
                                                  atRow: indexPath.row) else {
                                                    
                                                    return UITableViewCell()
        }
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.rawValue,
                                                    for: indexPath)
        if let cell = cell as? WMDetailTableViewCell {
            configureCell(cell, forCellIdentifier: cellIdentifier, atRow: indexPath.row)
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return nil
    }
    
    // *************************************************************************************************
    // # MARK: - Private Methods
    
    
    func cellIdentifier(forSectionId sectionId: SectionIdentifiers, atRow _: Int) -> CellIdentifiers? {
        switch sectionId {
        case .productMainSection:
            return .productMainCell
            
        case .productImageSection:
            return .productImageCell
            
        case .productDetailSection:
            return .productDetailCell
        }
    }
    
    func configureCell(_ cell: WMDetailTableViewCell,
                       forCellIdentifier cellIdentifier: CellIdentifiers,
                       atRow row: Int) {
        guard let product = product else {
            return
        }
        switch cellIdentifier {
        case .productMainCell:
            cell.title.text = product.productName
            cell.shortDescription.attributedText = product.attributedStortDiscription()
            cell.price.text = product.price
            cell.ratingView.rating = product.reviewRating!
            cell.rating.text = product.ratingText()
            cell.ratingCount.text = product.reviewCountText()
            cell.stockStatus.text = product.stockStatus()
            if product.inStock {
                cell.stockStatus.textColor = UIColor.inStockGreenColor
            } else {
                cell.stockStatus.textColor = UIColor.outOfStockRedColor
            }
        case .productImageCell:
            cell.productImage.sd_setImage(with: URL(string: product.productImageUrl ?? ""),
                                          placeholderImage: UIImage(named: "Placeholder.jpeg"))
            
        case .productDetailCell:
            cell.longDescription.attributedText = product.attributedLongDescription()
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
