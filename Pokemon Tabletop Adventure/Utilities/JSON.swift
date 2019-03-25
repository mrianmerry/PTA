//
//  JSON.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 08/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import Foundation

enum JSON {

    private static var cachedPokedex: Pokedex?

    /// Parse the bundled Pokedex and return it
    ///
    /// - Returns: The Pokedex value related to the bundled JSON
    static var pokedex: Pokedex {
        if let pokedex = cachedPokedex {
            return pokedex
        }

        let jsonDecoder = JSONDecoder()
        guard let pokedexJSON = getJSON(from: "pokedex"),
            let pokedex = try? jsonDecoder.decode(Pokedex.self, from: pokedexJSON) else {
           fatalError("Either could not read pokedex file, or could not convert pokedex json to data object!")
        }

        cachedPokedex = pokedex
        return pokedex
    }

    /// Parse the bundled Pokedex and return a list of the pokemon represented within
    ///
    /// - Returns: Array containing all the pokemon contained in the bundled pokedex
    static var pokemon: [Pokemon] {
        return pokedex.pokemon
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
