//
//  TweaksTests.swift
//  TweaksTests
//
//  Created by dasdom on 30.09.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import UIKit
import XCTest

class TweaksTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBlackColorCanBeCreatedWithHex() {
        let color = UIColor.colorFromHex("000000")
        
        assertColor(color, withRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    
    func testRedColorCanBeCreatedWithHex() {
        let color = UIColor.colorFromHex("FF0000")
        
        assertColor(color, withRed: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    
    func testGreenColorCanBeCreatedWithHex() {
        let color = UIColor.colorFromHex("00FF00")
        
        assertColor(color, withRed: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
    }
    
    func testBlueColorCanBeCreatedWithHex() {
        let color = UIColor.colorFromHex("0000FF")
        
        assertColor(color, withRed: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
    }
    
    func testWhiteColorCanBeCreatedWithHex() {
        let color = UIColor.colorFromHex("FFFFFF")
        
        assertColor(color, withRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func testHexFromRedUIColor() {
        let hexString = UIColor.redColor().hexString()
        
        XCTAssertEqual(hexString, "FF0000")
    }
    
    func testHexFromGreenUIColor() {
        let hexString = UIColor.greenColor().hexString()
        
        XCTAssertEqual(hexString, "00FF00")
    }
    
    func testHexFromBlueUIColor() {
        let hexString = UIColor.blueColor().hexString()
        
        XCTAssertEqual(hexString, "0000FF")
    }
    
    func assertColor(color: UIColor, withRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var redComponent = CGFloat()
        var greenComponent = CGFloat()
        var blueComponent = CGFloat()
        var alphaComponent = CGFloat()
        
        color.getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha: &alphaComponent)
        
        XCTAssertEqual(redComponent, red)
        XCTAssertEqual(greenComponent, green)
        XCTAssertEqual(blueComponent, blue)
        XCTAssertEqual(alphaComponent, alpha)
    }
    
}
