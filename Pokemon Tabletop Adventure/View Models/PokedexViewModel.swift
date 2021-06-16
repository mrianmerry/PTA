//
//  PokedexViewModel.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 10/08/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import UIKit

class PokedexViewModel: BaseViewModel {

    private var pokemon: [Pokemon]
    lazy var tableManager: TableManager = TableManager(with: "pokedex", rowCount: { [unowned self] _ -> Int in
        return self.pokemon.count
    }, sectionCount: { () -> Int in
        return 1
    }, cellConfiguration: { [unowned self] cell, index in
        let pokemon = self.pokemon[index]

        cell.detailTextLabel?.text = pokemon.name
        cell.textLabel?.text = pokemon.pokedexNumber.numeral()
    })

    override init() {
        let sortedPokemon = JSON.pokemon.sorted {
            if $0.pokedexNumber == $1.pokedexNumber {
                return $0.name < $1.name
            }
            return $0.pokedexNumber < $1.pokedexNumber
        }
        self.pokemon = sortedPokemon
    }
}
