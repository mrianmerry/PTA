//
//  WBPokémon.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 08/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import Foundation

struct Pokédex: Codable {
    let pokémon: [Pokémon]
}

struct Pokémon: Codable {
    let dexNumber: Int
    let name: String
    let stats: StatArray
    let type: [PokeType]
    let abilities: PokeAbilities
    let evolution: [String: Int]
    let biology: PokeBiology
    func basicDescription() -> String {
        return """
        Pokémon: \(name)
        Stats:
             HP: \(stats.HP)
            ATK: \(stats.ATK)
            DEF: \(stats.DEF)
            SPA: \(stats.SPA)
            SDF: \(stats.SDF)
            SPD: \(stats.SPD)
        """
    }
    private enum CodingKeys: String, CodingKey {
        case dexNumber = "id"
        case name
        case stats = "base_stats"
        case type
        case abilities
        case evolution
        case biology
    }
}

extension Pokémon: Equatable {}
func ==(lhs: Pokémon, rhs: Pokémon) -> Bool {
    let areEqual = lhs.dexNumber == rhs.dexNumber
    return areEqual
}

struct StatArray: Codable {
    let HP: Int
    let ATK: Int
    let DEF: Int
    let SPA: Int
    let SDF: Int
    let SPD: Int
}

struct PokeAbilities: Codable {
    // TODO: Change String to Ability once written
    let basic: [String]
    let high: [String]
}

struct PokeBiology: Codable {
    let height: PokeHeight
    let weight: PokeWeight
    let maleRatio: Double
    let eggGroup: [EggGroup]
    let hatchRate: Int?
    let diet: [DietType]
    let habitat: [Environment]
    
    private enum CodingKeys: String, CodingKey {
        case height
        case weight
        case maleRatio = "male_ratio"
        case eggGroup = "egg_group"
        case hatchRate = "hatch_rate"
        case diet
        case habitat
    }
}

struct PokeHeight: Codable {
    let value: Double
    let sizeClass: SizeClass
    
    private enum CodingKeys: String, CodingKey {
        case value
        case sizeClass = "class"
    }
}

struct PokeWeight: Codable {
    let value: Double
    let weightClass: Int
    
    private enum CodingKeys: String, CodingKey {
        case value
        case weightClass = "class"
    }
}

enum PokeType: String, Codable {
    case Grass
    case Poison
}

enum AbilityType: String, Codable {
    case basic
    case high
}

enum SizeClass: String, Codable {
    case Small
    case Medium
    case Large
}

enum EggGroup: String, Codable {
    case Dragon
    case Monster
    case Plant
}

enum DietType: String, Codable {
    case Carnivore
    case Herbivore
    case Omnivore
    case Phototroph
}

enum Environment: String, Codable {
    case Forest
    case Grassland
    case Rainforest
}
