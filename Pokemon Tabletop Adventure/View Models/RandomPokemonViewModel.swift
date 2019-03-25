//
//  RandomPokemonViewModel.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 09/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import Foundation

class RandomPokemonViewModel: BaseViewModel {
    private var pokemon = [Pokemon]()
    private var current: Pokemon?
    
    var describeCurrentPokemon: String {
        let pokemon = current ?? getRandomPokemon()
        return pokemon.basicDescription()
    }
    
    override init() {
        pokemon = JSON.pokemon
    }
    
    func getRandomPokemon() -> Pokemon {
        let random = pokemon.random(avoiding: current)
        print("Choosing pokemon #\(random.dexID) - \(random.name)")
        current = random
        return random
    }
}
