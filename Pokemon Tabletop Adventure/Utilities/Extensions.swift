//
//  Extensions.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 09/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import Foundation

public extension Int {
    public func written(digits: Int = 3) -> String {
        let writtenWithDigits = String(format: "%0\(digits)d", self)
        return writtenWithDigits
    }
}

public extension Optional {
    public var exists: Bool {
        return self != nil
    }
}

public extension Array where Element: Equatable {
    public func random(avoiding element: Element? = nil) -> Element {
        guard let element = element,
            let index = index(of: element) else { return trueRandom }

        var randomIndex = index
        while randomIndex == index {
            randomIndex = Int(arc4random_uniform(UInt32(count)))
        }

        return self[randomIndex]
    }

    public var trueRandom: Element {
        let randomIndex = Int(arc4random_uniform(UInt32(count)))
        return self[randomIndex]
    }

}
