//
//  LabelTests.swift
//  P:TA Companion Tests
//
//  Created by Ian Merryweather on 27/03/2019.
//  Copyright © 2019 Undersea Love. All rights reserved.
//

import XCTest

class LabelTests: XCTestCase {
    var testLabel: UILabel!
    var attributes: [NSAttributedString.Key: Any]!

    override func setUp() {
        super.setUp()
        testLabel = UILabel(frame: .zero)
        attributes = [.foregroundColor: UIColor.black]
        testLabel.attributedText = NSAttributedString(string: "setUp", attributes: attributes)
    }

    override func tearDown() {
        testLabel = nil
        super.tearDown()
    }

    func test_UpdateAttributedText_Nil() {
        XCTAssertTrue(testLabel.attributedText.exists)
        XCTAssertTrue(testLabel.attributedText.value == "setUp")

        testLabel.updateAttributedText(nil)
        XCTAssertTrue(testLabel.attributedText.isNone)
    }

    func test_UpdateAttributedText_EmptyString() {
        XCTAssertTrue(testLabel.attributedText.exists)
        XCTAssertTrue(testLabel.attributedText.value == "setUp")

        testLabel.updateAttributedText("")
        XCTAssertTrue(testLabel.attributedText.isNone)
    }

    func test_UpdateAttributedText_ValidString() {
        XCTAssertTrue(testLabel.attributedText.exists)
        XCTAssertTrue(testLabel.attributedText.value == "setUp")

        testLabel.updateAttributedText("test_UpdateAttributedText_ValidString")
        XCTAssertTrue(testLabel.attributedText.exists)
        XCTAssertTrue(testLabel.attributedText.value == "test_UpdateAttributedText_ValidString")
    }

    func test_Attributes_Nil() {
        XCTAssertFalse(testLabel.attributes.isEmpty)
        testLabel.updateAttributedText(nil)
        XCTAssertTrue(testLabel.attributes.isEmpty)
    }

    func test_Attributes_EmptyText() {
        XCTAssertFalse(testLabel.attributes.isEmpty)
        testLabel.updateAttributedText("")
        XCTAssertTrue(testLabel.attributes.isEmpty)
    }

    func test_Attributes_ValidText() {
        XCTAssertFalse(testLabel.attributes.isEmpty)
        XCTAssertTrue(testLabel.attributedText.value == "setUp")

        let testAttribute = attributes[.foregroundColor] as? UIColor
        let labelAttribute = testLabel.attributes[.foregroundColor] as? UIColor
        XCTAssertTrue(testAttribute.exists)
        XCTAssertTrue(labelAttribute.exists)
        XCTAssertTrue(testAttribute!.isEqual(labelAttribute)) //swiftlint:disable:this force_unwrapping
    }
}
