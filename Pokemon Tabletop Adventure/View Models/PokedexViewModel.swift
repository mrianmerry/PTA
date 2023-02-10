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
        cell.textLabel?.text = pokemon.ptaID.numeral()
    })

    override init() {
        let pokedex = JSON.pokedex
        let sortedPokemon = pokedex.pokemon.sorted { return $0.ptaID < $1.ptaID }
        self.pokemon = sortedPokemon
    }
}
