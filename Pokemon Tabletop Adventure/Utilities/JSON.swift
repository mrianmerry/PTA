//
//  JSON.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 08/07/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
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
        do {
            guard let pokedexJSON = getJSON(from: "pokedex") else {
                throw JSONError.pokedexDataNotJSON
            }
            let pokedex = try jsonDecoder.decode(Pokedex.self, from: pokedexJSON)
            cachedPokedex = pokedex
            return pokedex
        } catch {
            var description: String
            switch error as? DecodingError {
            case let .dataCorrupted(context): description = context.debugDescription
            case let .keyNotFound(_, context): description = context.debugDescription
            case let .typeMismatch(_, context): description = context.debugDescription
            case let .valueNotFound(_, context): description = context.debugDescription
            default: description = error.localizedDescription
            }
            print("PTAERROR:- Could not convert pokedex json to pokedex model. Error: \(description)")
            return Pokedex.empty
        }
    }

    /// Parse the bundled Pokedex and return a list of the pokemon represented within
    ///
    /// - Returns: Array containing all the pokemon contained in the bundled pokedex
    static var pokemon: [Pokemon] {
        return pokedex.pokemon
    }

    static func setupPokedexCache(completion: @escaping () -> Void) {
        cachedPokedex = pokedex
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
    
    private enum JSONError: Error {
        case pokedexDataNotJSON
        case pokedexFormatWrong
    }
}
