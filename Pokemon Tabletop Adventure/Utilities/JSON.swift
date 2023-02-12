//
//  JSON.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 08/07/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import Foundation

enum JSON {

    /// Parse the bundled Pokedex and return it
    ///
    /// - Returns: The Pokedex value related to the bundled JSON
    static var pokedex: Pokedex {
        if let pokedex = Pokedex.cachedPokedex {
            return pokedex
        } else {
            cachePokedex()
            return self.pokedex
        }
    }

    /// Parse the bundled Pokedex and return a list of the pokemon represented within
    ///
    /// - Returns: Array containing all the pokemon contained in the bundled pokedex
    static var pokemon: [Pokemon] {
        return pokedex.pokemon
    }
    
    private static func cachePokedex() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let pokedexJSON = try getJSON(from: "pokedex")
            let pokedex = try jsonDecoder.decode(Pokedex.self, from: pokedexJSON)
            Pokedex.cachedPokedex = pokedex
        } catch {
            logJsonFailure(error, for: "pokedex")
        }
    }
    
    private static func cachePokeMoves() {
        let filename = "moves"
        let jsonDecoder = JSONDecoder()
        
        do {
            let movesJSON = try getJSON(from: filename)
            let decoded = try jsonDecoder.decode([String: [PokeMove]].self, from: movesJSON)
            guard let moves = decoded["moves"] else { throw JSONError.incorrectDataFormat(filename: "\(filename).json") }
            PokeMove.cachedMoves = moves
        } catch {
            logJsonFailure(error, for: filename)
        }
    }
    
    private static func logJsonFailure(_ error: Error, for filename: String, in function: String = #function) {
        var description: String
        switch error as? DecodingError {
        case let .dataCorrupted(context): description = context.debugDescription
        case let .keyNotFound(_, context): description = context.debugDescription
        case let .typeMismatch(_, context): description = context.debugDescription
        case let .valueNotFound(_, context): description = context.debugDescription
        default: description = error.localizedDescription
        }
        print("PTAERROR:- Could not convert \(filename) to data model in \(function). Error: \(description)")
    }

    static func setupDataCache(completion: @escaping () -> Void) {
        cachePokeMoves()
        cachePokedex()
        DispatchQueue.main.async { completion() }
    }

    static func getJSON(from filename: String) throws -> Data {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Could not open file: \"\(filename)\"")
            throw JSONError.fileNotFound(filename: "\(filename).json")
        }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Error encountered while opening file \"\(filename)\":\n\(error)")
            throw JSONError.dataFileReadError(filename: "\(filename).json")
        }
    }
    
    private enum JSONError: Error {
        case dataFileReadError(filename: String)
        case fileNotFound(filename: String)
        case incorrectDataFormat(filename: String)
    }
}
