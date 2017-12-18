//
//  UIColorExtentionTest.swift
//  UnitTests
//
//  Created by Taranjit Lottey on 12/17/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

import XCTest

class UIColorExtentionTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInStockGreenColor() {
        let colorGreen = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
        XCTAssertEqual(colorGreen, UIColor.inStockGreenColor)
    }
    
    func testOutOfStockRedColor() {
        let colorGreen = #colorLiteral(red: 1, green: 0.08731482584, blue: 0.2058391994, alpha: 1)
        XCTAssertEqual(colorGreen, UIColor.outOfStockRedColor)
    }
    
}
