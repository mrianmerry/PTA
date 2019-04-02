//
//  StringTests.swift
//  P:TA Companion Tests
//
//  Created by Ian Merryweather on 27/03/2019.
//  Copyright © 2019 Undersea Love. All rights reserved.
//

import XCTest

class StringTests: XCTestCase {
    func test_HTML() {
        let testString = "<p><i>Some test <b>HTML</b> that is malformed"
        XCTAssertTrue(testString.html.exists)
    }

    func test_HTMLBasic() {
        let testString = "<p>some basic html</p>"
        XCTAssertTrue(testString.htmlBasic == testString.html.value)
    }
}
