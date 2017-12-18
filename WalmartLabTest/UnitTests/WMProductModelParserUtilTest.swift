//
//  WMProductModelParserUtilTest.swift
//  UnitTests
//
//  Created by Taranjit Lottey on 12/17/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

import XCTest

class WMProductModelParserUtilTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInvalidJson() {
        let testJson = "[{\"productName\": \"Samsung 50 Class 4K Ultra HD LED Smart TV - UN50JU650DFXZA\",\"shortDescription\": \"Resolution: 4K Ultra HD\",\"longDescription\": \"With 4K UHD resolution you&rsquo;ll enjoy a picture with 4X the detail of Full HD. Watch and play your way with the advanced Samsung Smart TV platform that lets you quickly and easily access your favorite content. Upgrade all lower resolution media to a stunning near ultra high-definition experience with enhanced detail and optimized picture quality. Experience UHD picture quality with deeper blacks, purer whites, brighter colors, and enhanced detail in every image. Enjoy improved fast-action moving picture resolution at Motion Rate 120 with outstanding refresh rate, processing speed and backlight technology. The screen mirroring feature allows you to mirror your phone or other compatible mobile device&rsquo;s screen onto the TVs screen wirelessly instead of your devices smaller screen for showing content, media playback, or other function. Have your Samsung Smart TV act as an alarm when synchronized with your other Samsung mobile devices. Use the large screen to display important items such as the time, weather, and your daily schedule.\",\"price\": \"$928.00\",\"productImage\": \"https://walmartlabs-test.appspot.com/images/image5.jpeg\",\"reviewRating\": 4.5,\"reviewCount\": 2,\"inStock\": true}]"
        
        var testData = Array<Dictionary<String, AnyObject>>()
        if let data = testJson.data(using: .utf8) {
            do {
                testData = (try JSONSerialization.jsonObject(with: data, options: []) as? Array<Dictionary<String, AnyObject>>)!
            } catch {
                print(error.localizedDescription)
            }
        }
        let allProductModels = WMProductModelParserUtil.parseProductData(jsonArray: testData)
        XCTAssertEqual(allProductModels.count, 0)
    }
    
    func testValidJson() {
        let testJson = "[{\"productId\": \"0150f9b5-8918-4fd1-92b3-fc032cc6c684\",\"productName\": \"Samsung 50 Class 4K Ultra HD LED Smart TV - UN50JU650DFXZA\",\"shortDescription\": \"Resolution: 4K Ultra HD\",\"longDescription\": \"With 4K UHD resolution you&rsquo;ll enjoy a picture with 4X the detail of Full HD. Watch and play your way with the advanced Samsung Smart TV platform that lets you quickly and easily access your favorite content. Upgrade all lower resolution media to a stunning near ultra high-definition experience with enhanced detail and optimized picture quality. Experience UHD picture quality with deeper blacks, purer whites, brighter colors, and enhanced detail in every image. Enjoy improved fast-action moving picture resolution at Motion Rate 120 with outstanding refresh rate, processing speed and backlight technology. The screen mirroring feature allows you to mirror your phone or other compatible mobile device&rsquo;s screen onto the TVs screen wirelessly instead of your devices smaller screen for showing content, media playback, or other function. Have your Samsung Smart TV act as an alarm when synchronized with your other Samsung mobile devices. Use the large screen to display important items such as the time, weather, and your daily schedule.\",\"price\": \"$928.00\",\"productImage\": \"https://walmartlabs-test.appspot.com/images/image5.jpeg\",\"reviewRating\": 4.5,\"reviewCount\": 2,\"inStock\": true}]"
        
        var testData = Array<Dictionary<String, AnyObject>>()
        if let data = testJson.data(using: .utf8) {
            do {
                testData = (try JSONSerialization.jsonObject(with: data, options: []) as? Array<Dictionary<String, AnyObject>>)!
            } catch {
                print(error.localizedDescription)
            }
        }
        let allProductModels = WMProductModelParserUtil.parseProductData(jsonArray: testData)
        XCTAssertEqual(allProductModels.count, 1)
        let newModel = allProductModels[0]
        XCTAssertEqual(newModel.productId, "0150f9b5-8918-4fd1-92b3-fc032cc6c684")
        // Can check all values here
    }
    
}
