//
//  RandomPokemonViewModel.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 09/07/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import Foundation

class RandomPokemonViewModel: BaseViewModel {
    private var pokemon: [Pokemon] = []
    private var current: Pokemon?
    
    var describeCurrentPokemon: String {
        let pokemon = current ?? getRandomPokemon()
        return pokemon.basicDescription
    }
    
    override init() {
        pokemon = JSON.pokemon
    }
    
    func getRandomPokemon() -> Pokemon {
        let random = pokemon.random(avoiding: current)
        print("Choosing pokemon #\(random.pokedexNumber) - \(random.name)")
        current = random
        return random
    }
}

extension Pokemon {
    var basicDescription: String {
        return """
        Pokemon: \(name)
        Base Stats:
             HP: \(stats.hitPoints)
            ATK: \(stats.attack)
            DEF: \(stats.defense)
            SPA: \(stats.specialAttack)
            SDF: \(stats.specialDefense)
            SPD: \(stats.speed)
        """
    }
}
