//
//  WBRandomPokémonViewModel.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 09/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import Foundation

class WBRandomPokémonViewModel: WBBaseViewModel {
    private var pokémon = [Pokémon]()
    
    override init() {
        pokémon = WBJSON.pokémon()
    }
    
    func getRandomPokémon() -> Pokémon? {
        return pokémon.random
    }
}
