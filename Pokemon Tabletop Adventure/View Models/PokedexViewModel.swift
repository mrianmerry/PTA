//
//  PokedexViewModel.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 10/08/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import UIKit

class PokedexViewModel: BaseViewModel {

    private var pokedex: Pokedex
    let tableManager: TableManager

    override init() {
        let pokedex = JSON.pokedex
        self.pokedex = pokedex

        tableManager = TableManager(with: "pokedex", rowCount: { _ -> Int in
            return pokedex.pokemon.count
        }, sectionCount: { () -> Int in
            return 1
        }, cellConfiguration: { cell, index in
            let pokemon = pokedex.pokemon[index]

            cell.detailTextLabel?.text = pokemon.name
            cell.textLabel?.text = pokemon.dexID.written()
        })
    }
}
