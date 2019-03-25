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
    let tableManager: WBTableManager

    override init() {
        let pokédex = WBJSON.pokédex
        self.pokédex = pokédex

        tableManager = WBTableManager(with: "pokédex", rowCount: { _ -> Int in
            return pokédex.pokémon.count
        }, sectionCount: { () -> Int in
            return 1
        }, cellConfiguration: { cell, index in
            let pokémon = pokédex.pokémon[index]

            cell.detailTextLabel?.text = pokémon.name
            cell.textLabel?.text = pokémon.dexID.written()
        })
    }
}
