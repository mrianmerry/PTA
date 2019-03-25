//
//  PokedexViewModel.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 10/08/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import UIKit

enum PokemonIdentifier {
    case nationalPokedex
    case tabletopAdventure

    var sortTitle: String {
        return self == .nationalPokedex ? "Tabletop 'dex" : "National 'dex"
    }
}

class PokedexViewModel: BaseViewModel {

    private var pokemon: [Pokemon]
    var pokemonSorting: PokemonIdentifier = .nationalPokedex
    lazy var tableManager: TableManager = TableManager(with: "pokedex", rowCount: { [unowned self] _ -> Int in
        return self.pokemon.count
    }, sectionCount: { () -> Int in
        return 1
    }, cellConfiguration: { [unowned self] cell, index in
        let pokemon = self.pokemon[index]

        cell.detailTextLabel?.text = pokemon.name
        let pokemonIdentifier = self.pokemonSorting == .nationalPokedex ? pokemon.dexID : pokemon.ptaID
        cell.textLabel?.text = pokemonIdentifier.written()
    })

    override init() {
        let pokedex = JSON.pokedex
        let sortedPokemon = pokedex.pokemon.sorted { return $0.dexID < $1.dexID }
        self.pokemon = sortedPokemon
    }

    func toggleSort() {
        pokemonSorting = pokemonSorting == .nationalPokedex ? .tabletopAdventure : .nationalPokedex
        pokemon.sort { first, last -> Bool in
            switch pokemonSorting {
            case .nationalPokedex: return first.dexID < last.dexID
            case .tabletopAdventure: return first.ptaID < last.ptaID
            }
        }
    }
}
