//
//  ProgressTests.swift
//  P:TA Companion Tests
//
//  Created by DevPair21 on 01/04/2019.
//  Copyright © 2019 Undersea Love. All rights reserved.
//

import XCTest

class ProgressTests: XCTestCase {
    var subject: UIProgressView!

    override func setUp() {
        super.setUp()
        subject = UIProgressView()
        subject.progressTintColor = .blue
        subject.trackTintColor = .green
    }

    override func tearDown() {
        subject = nil
        super.tearDown()
    }

    func test_Loop() {
        subject.setProgress(0.5, animated: false)

        XCTAssertTrue(subject.progress == 0.5)
        XCTAssertTrue(subject.progressTintColor == .blue)
        XCTAssertTrue(subject.trackTintColor == .green)

        subject.loop()
        XCTAssertTrue(subject.progress == 0)
        XCTAssertTrue((subject.progressTintColor?.isEqual(UIColor.green)).orFalse)
        XCTAssertTrue((subject.trackTintColor?.isEqual(UIColor.blue)).orFalse)
    }
}
