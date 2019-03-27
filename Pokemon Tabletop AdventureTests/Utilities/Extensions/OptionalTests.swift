//
//  OptionalTests.swift
//  Pokemon Tabletop AdventureTests
//
//  Created by Ian Merryweather on 26/07/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import XCTest

class OptionalTests: XCTestCase {
    func test_Exists() {
        var testOptional: Int?
        XCTAssertFalse(testOptional.exists)
        
        testOptional = 1
        XCTAssertTrue(testOptional.exists)
    }

    func test_IsNone() {
        var testOptional: Int?
        XCTAssertTrue(testOptional.isNone)

        testOptional = 1
        XCTAssertFalse(testOptional.isNone)
    }

    func test_OrEmpty_String() {
        var testString: String?
        XCTAssertTrue(testString.orEmpty.isEmpty)

        testString = "testString"
        XCTAssertFalse(testString.orEmpty.isEmpty)
    }

    func test_OrFalse_Bool() {
        var testBool: Bool? //swiftlint:disable:this discouraged_optional_boolean
        XCTAssertFalse(testBool.orFalse)

        testBool = false
        XCTAssertFalse(testBool.orFalse)

        testBool = true
        XCTAssertTrue(testBool.orFalse)
    }

    func test_OrZero_Int() {
        var testInt: Int?
        XCTAssertTrue(testInt.orZero == 0)

        testInt = 1
        XCTAssertFalse(testInt.orZero == 0)
    }

    func test_OrZero_Double() {
        var testDouble: Double?
        XCTAssertTrue(testDouble.orZero == 0.0)

        testDouble = 1.0
        XCTAssertFalse(testDouble.orZero == 0.0)
    }

    func test_OrZero_Float() {
        var testFloat: Float?
        XCTAssertTrue(testFloat.orZero == 0.0)

        testFloat = 1.0
        XCTAssertFalse(testFloat.orZero == 0.0)
    }

    func test_Value_AttributedString() {
        var testAttributedString: NSAttributedString?
        XCTAssertTrue(testAttributedString.value.isEmpty)

        let expectedString = "testAttributedString"
        testAttributedString = NSAttributedString(string: expectedString)
        XCTAssertFalse(testAttributedString.value.isEmpty)
        XCTAssertTrue(testAttributedString.value == expectedString)
    }
}
