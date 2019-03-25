//
//  ArrayTests.swift
//  Pokemon Tabletop AdventureTests
//
//  Created by Ian Merry on 18/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
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
    
    func testRandomAvoidingElementHappyPath() {
        let element = testArray[0]

        let testValue = testArray.random(avoiding: element)
        XCTAssert(testArray.contains(testValue), "returned value not in array?!")
        XCTAssert(testArray.index(of: element) != testArray.index(of: testValue), "Test Value and Element had same index")
    }
    
    func testTrueRandom() {
        let testElement = testArray.trueRandom
        XCTAssert(testArray.index(of: testElement).exists, "Test Element \"\(testElement)\" not found in Test Array")
    }
    
//    func testPerformanceRandomAvoidingElement() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
