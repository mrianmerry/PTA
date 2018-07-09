//
//  Extensions.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 09/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import Foundation

extension Array {
    var random: Element {
        let randomIndex = arc4random_uniform(UInt32(self.count))
        return self[Int(randomIndex)]
    }
}
