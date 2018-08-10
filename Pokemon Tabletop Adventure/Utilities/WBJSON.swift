//
//  WBJSON.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 08/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import Foundation

class WBJSON {

    private static var cachedPokédex: Pokédex?

    /// Parse the bundled Pokédex and return it
    ///
    /// - Returns: The Pokédex value related to the bundled JSON
    static var pokédex: Pokédex {
        if let pokédex = cachedPokédex {
            return pokédex
        }

        let jsonDecoder = JSONDecoder()
        guard let pokédexJSON = getJSON(from: "pokédex"),
            let pokédex = try? jsonDecoder.decode(Pokédex.self, from: pokédexJSON) else {
           fatalError("Either could not read pokédex file, or could not convert pokédex json to data object!")
        }

        cachedPokédex = pokédex
        return pokédex
    }

    /// Parse the bundled Pokédex and return a list of the pokémon represented within
    ///
    /// - Returns: Array containing all the pokémon contained in the bundled pokédex
    static var pokémon: [Pokémon] {
        return pokédex.pokémon
    }
    
    static func getJSON(from filename: String) -> Data? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Could not open file: \"\(filename)\"")
            return nil
        }

        /* I would like to make this a guard, but I'm not sure how to get the error message into the following:
         guard let foo = try? bar else { print(error) } */

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Error encountered while opening file \"\(filename)\":\n\(error)")
            return nil
        }
    }
}
