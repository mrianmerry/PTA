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
    private var current: Pokémon?
    
    var describeCurrentPokémon: String {
        let pokémon = current ?? getRandomPokémon()
        return pokémon.basicDescription()
    }
    
    override init() {
        pokémon = WBJSON.pokémon
    }
    
    func getRandomPokémon() -> Pokémon {
        let random = pokémon.random(avoiding: current)
        print("Choosing pokémon #\(random.dexID) - \(random.name)")
        current = random
        return random
    }
}
