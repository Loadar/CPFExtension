//
//  FontTests.swift
//  CPFExtensionsTests
//
//  Created by Aaron on 2018/4/3.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import XCTest
import CPFExtensions

class FontTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFontWithName() {
        let fontName = "PingFangTC-Medium"
        let font = UIFont.cpf_font(fontName, size: 14)
        XCTAssertNotNil(font)
        XCTAssertEqual(font.fontName, fontName)
        XCTAssertEqual(font.pointSize, 14)
    }
    
    func testFontPingFangSC() {
        let pingFangBaseName = "PingFangSC"

        // ultralight
        var weight: CPFFontName.Weight = .ultraLight
        //let weights: [CPFFontName.Weight] = [.ultraLight, .thin, .light, .regular, .medium, .semibold, .bold, .heavy, .black]
        var font = UIFont.cpf_pingFang(weight, size: 14)
        XCTAssertEqual(font.fontName, pingFangBaseName + "-Ultralight")
        XCTAssertEqual(font.pointSize, 14)
        
        // semibold
        weight = .semibold
        font = UIFont.cpf_pingFang(weight, size: 14)
        XCTAssertEqual(font.fontName, pingFangBaseName + "-Semibold")
        XCTAssertEqual(font.pointSize, 14)

        // light
        weight = .light
        font = UIFont.cpf_pingFang(weight, size: 14)
        XCTAssertEqual(font.fontName, pingFangBaseName + "-Light")
        XCTAssertEqual(font.pointSize, 14)

        // medium
        weight = .medium
        font = UIFont.cpf_pingFang(weight, size: 14)
        XCTAssertEqual(font.fontName, pingFangBaseName + "-Medium")
        XCTAssertEqual(font.pointSize, 14)

        // thin
        weight = .thin
        font = UIFont.cpf_pingFang(weight, size: 14)
        XCTAssertEqual(font.fontName, pingFangBaseName + "-Thin")
        XCTAssertEqual(font.pointSize, 14)

        // regular
        weight = .regular
        font = UIFont.cpf_pingFang(weight, size: 14)
        XCTAssertEqual(font.fontName, pingFangBaseName + "-Regular")
        XCTAssertEqual(font.pointSize, 14)

        // bold
        weight = .bold
        font = UIFont.cpf_pingFang(weight, size: 14)
        XCTAssertEqual(font.fontName, pingFangBaseName + "-Regular")
        XCTAssertEqual(font.pointSize, 14)

        // heavy
        weight = .heavy
        font = UIFont.cpf_pingFang(weight, size: 14)
        XCTAssertEqual(font.fontName, pingFangBaseName + "-Regular")
        XCTAssertEqual(font.pointSize, 14)

        // black
        weight = .black
        font = UIFont.cpf_pingFang(weight, size: 14)
        XCTAssertEqual(font.fontName, pingFangBaseName + "-Regular")
        XCTAssertEqual(font.pointSize, 14)
    }
    
}

