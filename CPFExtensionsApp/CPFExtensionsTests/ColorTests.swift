//
//  ColorTests.swift
//  CPFExtensionsTests
//
//  Created by Aaron on 2018/4/3.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import XCTest

class ColorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testColorWithHex() {
        let text = "112233"
        let color = UIColor.cpf_hex(text)
        let colorWithAlpha = UIColor.cpf_hex(text, alpha: 0.5)
        
        print("color:", color)
        print("colorWithAlpha:", colorWithAlpha)
        XCTAssertNotNil(color)
        XCTAssertNotNil(colorWithAlpha)
    }
    
    func testColorWithRGB() {
        let red: CGFloat = 0.3
        let green: CGFloat = 0.7
        let blue: CGFloat = 0.28
        let alpha: CGFloat = 0.41
        
        let colorRGB = UIColor.cpf_rgb(red, green, blue)
        let colorRGBA = UIColor.cpf_rgba(red, green, blue, alpha)
        print("colorRGB:", colorRGB)
        print("colorRGBA:", colorRGBA)
        XCTAssertNotNil(colorRGB)
        XCTAssertNotNil(colorRGBA)
    }
    
    func testColorAlpha() {
        let alpha: CGFloat = 0.88
        let color = UIColor.purple
        let colorWithAlpha = color.cpf_alpha(alpha)
        
        XCTAssertNotNil(colorWithAlpha)
    }
    
    func testColorToHex() {
        let text = "348811"
        let textWithAlpha = "348811a0"
        let color = UIColor.cpf_hex(text)
        let colorWithAlpha = UIColor.cpf_hex(textWithAlpha)
        let finalText = color.cpf_hexString(showAll: false)
        let finalTextWithAlpha = colorWithAlpha.cpf_hexString(showAll: true)
        
        XCTAssertEqual(text, finalText)
        XCTAssertEqual(textWithAlpha, finalTextWithAlpha)
    }
}

