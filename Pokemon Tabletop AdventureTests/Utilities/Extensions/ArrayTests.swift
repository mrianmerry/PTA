//
//  ArrayTests.swift
//  Pokemon Tabletop AdventureTests
//
//  Created by Ian Merryweather on 18/07/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import XCTest

class ArrayTests: XCTestCase {
    var testArray: [Int]!
    
    override func setUp() {
        super.setUp()
        testArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    }
    
    override func tearDown() {
        testArray = nil
        super.tearDown()
    }
    
    func test_RandomAvoidingElement_HappyPath() {
        let element = testArray[0]

        let testValue = testArray.random(avoiding: element)
        XCTAssertTrue(testArray.contains(testValue))
        XCTAssertTrue(testArray.firstIndex(of: element) != testArray.firstIndex(of: testValue))
    }

    func test_RandomAvoidingElement_NoElement() {
        let testValue = testArray.random()
        XCTAssertTrue(testArray.contains(testValue))
    }

    func test_RandomAvoidingElement_BadIndex() {
        let element = 10
        XCTAssertFalse(testArray.contains(element))

        let testValue = testArray.random(avoiding: element)
        XCTAssertTrue(testArray.contains(testValue))
    }
    
    func test_TrueRandom() {
        let testElement = testArray.trueRandom
        XCTAssertTrue(testArray.firstIndex(of: testElement).exists)
    }    
}
