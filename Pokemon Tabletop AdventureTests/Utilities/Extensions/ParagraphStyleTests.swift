//
//  ParagraphStyleTests.swift
//  P:TA Companion Tests
//
//  Created by DevPair21 on 27/03/2019.
//  Copyright © 2019 Undersea Love. All rights reserved.
//

import XCTest

class ParagraphStyleTests: XCTestCase {
    func test_centered() {
        let testParagraphStyle = NSParagraphStyle.centered
        XCTAssertTrue(testParagraphStyle.alignment == .center)

        let defaultStyle = NSParagraphStyle()
        XCTAssertFalse(testParagraphStyle.alignment == defaultStyle.alignment)
        XCTAssertTrue(testParagraphStyle.allowsDefaultTighteningForTruncation == defaultStyle.allowsDefaultTighteningForTruncation)
        XCTAssertTrue(testParagraphStyle.baseWritingDirection == defaultStyle.baseWritingDirection)
        XCTAssertTrue(testParagraphStyle.defaultTabInterval == defaultStyle.defaultTabInterval)
        XCTAssertTrue(testParagraphStyle.firstLineHeadIndent == defaultStyle.firstLineHeadIndent)
        XCTAssertTrue(testParagraphStyle.headIndent == defaultStyle.headIndent)
        XCTAssertTrue(testParagraphStyle.hyphenationFactor == defaultStyle.hyphenationFactor)
        XCTAssertTrue(testParagraphStyle.lineBreakMode == defaultStyle.lineBreakMode)
        XCTAssertTrue(testParagraphStyle.lineHeightMultiple == defaultStyle.lineHeightMultiple)
        XCTAssertTrue(testParagraphStyle.lineSpacing == defaultStyle.lineSpacing)
        XCTAssertTrue(testParagraphStyle.maximumLineHeight == defaultStyle.maximumLineHeight)
        XCTAssertTrue(testParagraphStyle.minimumLineHeight == defaultStyle.minimumLineHeight)
        XCTAssertTrue(testParagraphStyle.paragraphSpacing == defaultStyle.paragraphSpacing)
        XCTAssertTrue(testParagraphStyle.paragraphSpacingBefore == defaultStyle.paragraphSpacingBefore)
        XCTAssertTrue(testParagraphStyle.tabStops == defaultStyle.tabStops)
        XCTAssertTrue(testParagraphStyle.tailIndent == defaultStyle.tailIndent)
    }
}
