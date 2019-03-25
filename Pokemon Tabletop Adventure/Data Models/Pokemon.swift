//
//  Pokemon.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 08/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import Foundation

struct Pokedex: Codable {
    let pokemon: [Pokemon]
}

struct Pokemon: Codable, Equatable {
    let dexID: Int
    let ptaID: Int
    let name: String
    let stats: StatArray
    let type: [PokeType]
    let abilities: PokeAbilities
    let evolution: [String: String]
    let biology: PokeBiology

    func basicDescription() -> String {
        return """
        Pokemon: \(name)
        Base Stats:
             HP: \(stats.HP)
            ATK: \(stats.ATK)
            DEF: \(stats.DEF)
            SPA: \(stats.SPA)
            SDF: \(stats.SDF)
            SPD: \(stats.SPD)
        """
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        let areEqual = lhs.dexID == rhs.dexID
        return areEqual
    }
    
    private enum CodingKeys: String, CodingKey {
        case dexID = "dexID"
        case ptaID = "ptaID"
        case name = "name"
        case stats = "base_stats"
        case type = "type"
        case abilities = "abilities"
        case evolution = "evolution"
        case biology = "biology"
    }
}

struct StatArray: Codable {
    let HP: Int // swiftlint:disable:this identifier_name
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
        case height = "height"
        case weight = "weight"
        case maleRatio = "male_ratio"
        case eggGroup = "egg_group"
        case hatchRate = "hatch_rate"
        case diet = "diet"
        case habitat = "habitat"
    }
}

struct PokeHeight: Codable {
    let value: Double
    let sizeClass: SizeClass

    private enum CodingKeys: String, CodingKey {
        case value = "value"
        case sizeClass = "class"
    }
}

struct PokeWeight: Codable {
    let value: Double
    let weightClass: Int

    private enum CodingKeys: String, CodingKey {
        case value = "value"
        case weightClass = "class"
    }
}

enum PokeType: String, Codable {
    case dark = "Dark"
    case fairy = "Fairy"
    case fire = "Fire"
    case fighting = "Fighting"
    case flying = "Flying"
    case ghost = "Ghost"
    case grass = "Grass"
    case ground = "Ground"
    case poison = "Poison"
    case psychic = "Psychic"
    case steel = "Steel"
    case water = "Water"
}

enum AbilityType: String, Codable {
    case basic = "basic"
    case high = "high"
}

enum SizeClass: String, Codable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

enum EggGroup: String, Codable {
    case dragon = "Dragon"
    case field = "Field"
    case flying = "Flying"
    case humanshape = "Humanshape"
    case monster = "Monster"
    case plant = "Plant"
    case waterOne = "Water 1"
}

enum DietType: String, Codable {
    case carnivore = "Carnivore"
    case herbivore = "Herbivore"
    case omnivore = "Omnivore"
    case phototroph = "Phototroph"
}

enum Environment: String, Codable {
    case beach = "Beach"
    case cave = "Cave"
    case forest = "Forest"
    case freshwater = "Freshwater"
    case grassland = "Grassland"
    case marsh = "Marsh"
    case mountain = "Mountain"
    case ocean = "Ocean"
    case rainforest = "Rainforest"
    case taiga = "Taiga"
    case tundra = "Tundra"
    case urban = "Urban"
}
