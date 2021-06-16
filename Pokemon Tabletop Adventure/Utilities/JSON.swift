//
//  JSON.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 08/07/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import Foundation

enum JSON {

    private static var cachedPokemon: [Pokemon]?

    /// Parse the bundled Pokedex and return it
    ///
    /// - Returns: The Pokedex value related to the bundled JSON
    static var pokemon: [Pokemon] {
        if let pokedex = cachedPokemon {
            return pokedex
        }

        let jsonDecoder = JSONDecoder()
        guard let pokedexJSON = getJSON(from: "pokedex backup") else {
           fatalError("Could not convert the pokedex file into usable data")
        }
        
        var pokemon: [Pokemon] = []
        do {
            pokemon = try jsonDecoder.decode([Pokemon].self, from: pokedexJSON)
        } catch { print("Failed decoding json:", error) }
        
        cachedPokemon = pokemon
        return pokemon
    }

    static func setupPokemonCache(completion: @escaping () -> Void) {
        cachedPokemon = pokemon
        DispatchQueue.main.async { completion() }
    }

    static func getJSON(from filename: String) -> Data? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Could not open file: \"\(filename)\"")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Error encountered while opening file \"\(filename)\":\n\(error)")
            return nil
        }
    }
}
