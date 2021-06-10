//
//  ActionDelegate.swift
//  PTA Companion
//
//  Created by Ian Merryweather on 10/06/2021.
//  Copyright © 2021 Undersea Love. All rights reserved.
//

import Foundation

protocol ActionDelegate: class {
    func respondToAction(_ action: Action)
}

enum Action {
    case preliminaryLoadingCompleted
}
