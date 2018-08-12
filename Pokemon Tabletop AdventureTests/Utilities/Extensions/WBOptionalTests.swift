//
//  WBOptionalTests.swift
//  Pokemon Tabletop AdventureTests
//
//  Created by Ian Merry on 26/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import XCTest

class WBOptionalTests: XCTestCase {
    
    func testExists() {
        var testOptional: Int? = nil
        XCTAssert(!testOptional.exists, "Evaluated true instead of false")
        
        testOptional = 1
        XCTAssert(testOptional.exists, "Evaluated false instead of true")
    }
    
}
