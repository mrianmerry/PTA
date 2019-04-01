//
//  ColorTests.swift
//  P:TA Companion Tests
//
//  Created by DevPair21 on 27/03/2019.
//  Copyright © 2019 Undersea Love. All rights reserved.
//

import XCTest

class ColorTests: XCTestCase {
    func test_AppLogo() {
        let testColor = UIColor.appLogo
        let expectation = UIColor(hex: "#eb463c")

        XCTAssertTrue(testColor.isEqual(expectation))
    }

    func test_Inverted() {
        let testColour = UIColor(red: 0.75, green: 0.75, blue: 0.25, alpha: 0.5)
        let expectation = UIColor(red: 0.25, green: 0.25, blue: 0.75, alpha: 0.5)
        let inverted = testColour.inverted

        XCTAssertTrue(inverted.isEqual(expectation))
        XCTAssertFalse(inverted.isEqual(testColour))
    }

    func test_Inverse_True() {
        let testColour = UIColor(red: 0.25, green: 0.25, blue: 0.5, alpha: 0.75)
        let expectation = UIColor(red: 0.75, green: 0.75, blue: 0.5, alpha: 0.25)
        let inverted = testColour.inverse(includingAlpha: true)

        XCTAssertTrue(inverted.isEqual(expectation))
        XCTAssertFalse(inverted.isEqual(testColour))
        XCTAssertTrue(expectation.inverse(includingAlpha: true).isEqual(testColour))
    }

    func test_Inverse_False() {
        let testColour = UIColor(red: 0.25, green: 0.25, blue: 0.5, alpha: 0.75)
        let expectation = UIColor(red: 0.75, green: 0.75, blue: 0.5, alpha: 0.75)
        let inverted = testColour.inverse(includingAlpha: false)

        XCTAssertTrue(inverted.isEqual(expectation))
        XCTAssertFalse(inverted.isEqual(testColour))
        XCTAssertTrue(expectation.inverse(includingAlpha: false).isEqual(testColour))
    }

    func test_Inverse_Inverted() {
        let testColour = UIColor(red: 0.75, green: 0.25, blue: 0.5, alpha: 0.75)

        XCTAssertTrue(testColour.inverse(includingAlpha: false).isEqual(testColour.inverted))
        XCTAssertFalse(testColour.inverse(includingAlpha: true).isEqual(testColour.inverted))
    }

    func test_HexString_EmptyHex() {
        let testHex = ""
        let testColour = UIColor(hex: testHex)
        let expectation = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        XCTAssertTrue(testColour.isEqual(expectation))
    }

    func test_HexString_3Char() {
        let testHex = "f00"
        let testColour = UIColor(hex: testHex)
        let expectation = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        XCTAssertTrue(testColour.isEqual(expectation))
    }

    func test_HexString_4Char() {
        let testHex = "foof"
        let testColour = UIColor(hex: testHex)
        let expectation = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        XCTAssertTrue(testColour.isEqual(expectation))
    }

    func test_HexString_6Char() {
        let testHex = "ffff00"
        let testColour = UIColor(hex: testHex)
        let expectation = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
        XCTAssertTrue(testColour.isEqual(expectation))
    }

    func test_HexString_8Char() {
        let testHex = "ff00ff00"
        let testColour = UIColor(hex: testHex)
        let expectation = UIColor(red: 1, green: 0, blue: 1, alpha: 0)
        XCTAssertTrue(testColour.isEqual(expectation))
    }

    func test_HexString_3CharPlusHash() {
        let testHex = "#0ff"
        let testColour = UIColor(hex: testHex)
        let expectation = UIColor(red: 0, green: 1, blue: 1, alpha: 1)
        XCTAssertTrue(testColour.isEqual(expectation))
    }

    func test_HexString_6CharPlusHash() {
        let testHex = "#ff00ff"
        let testColour = UIColor(hex: testHex)
        let expectation = UIColor(red: 1, green: 0, blue: 1, alpha: 1)
        XCTAssertTrue(testColour.isEqual(expectation))
    }

    func test_HexString_8CharPlusHash() {
        let testHex = "#00ff00ff"
        let testColour = UIColor(hex: testHex)
        let expectation = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        XCTAssertTrue(testColour.isEqual(expectation))
    }
}
