//
//  IntTests.swift
//  Pokemon Tabletop AdventureTests
//
//  Created by Ian Merryweather on 27/03/2019.
//  Copyright © 2019 Undersea Love. All rights reserved.
//

import XCTest

class IntTests: XCTestCase {
    func test_NumeralWithDigits_Default() {
        let testInt: Int = 0
        let testNumeral = testInt.numeral()
        XCTAssertTrue(testNumeral == "000")
    }

    func test_NumeralWithDigits_Explicit() {
        let testInt = 0
        let testNumeral = testInt.numeral(withDigits: 5)
        XCTAssertTrue(testNumeral == "00000")
    }

    func test_NumeralWithDigits_Overflow() {
        let testInt = 1000
        let testNumeral = testInt.numeral()
        XCTAssertTrue(testNumeral == "1000")
    }

    func test_NumeralWithDigits_Negative() {
        var testInt = -1000
        var testNumeral = testInt.numeral()
        XCTAssertTrue(testNumeral == "-1000")

        testInt = -10
        testNumeral = testInt.numeral()
        XCTAssertTrue(testNumeral == "-10")

        testInt = -1
        testNumeral = testInt.numeral()
        XCTAssertTrue(testNumeral == "-01")
    }
}
