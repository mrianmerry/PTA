//
//  WBJSON.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 08/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import Foundation

class WBJSON {
    
    /// Parse the bundled Pokédex and return a list of the pokémon represented within
    ///
    /// - Returns: Array containing all the pokémon contained in the bundled pokédex
    static func pokémon() -> [Pokémon] {
        
        guard let pokédexJSON = getJSON(from: "pokédex") else {
            print("No data for pokédex! Returning empty pokémon list")
            return []
        }
        
        let jsonDecoder = JSONDecoder()
        do {
            let pokédex = try jsonDecoder.decode(Pokédex.self, from: pokédexJSON)
            return pokédex.pokémon
        } catch {
            print("Could not retrieve pokémon from pokédex json!")
            return []
        }
    }
    
    
    private static func getJSON(from filename: String) -> Data? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("Error encountered while opening file \"\(filename)\":\n\(error)")
            }
        } else {
            print("Could not open file: \"\(filename)\"")
        }
        
        return nil
    }
}
