//
//  WBPokédexViewModel.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 10/08/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import UIKit

class WBPokédexViewModel: WBBaseViewModel {
    private var pokédex: Pokédex

    override init() {
        pokédex = WBJSON.pokédex
    }
}
