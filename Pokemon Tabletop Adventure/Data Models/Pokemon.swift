//
//  Pokemon.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 08/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let dexNumber: Int
    let name: String
    let stats: StatArray
    let type: [PokeType]
    let abilities: [AbilityType: [String]] // TODO: Change [String] to [PokeAbility] once written
    let evolution: [String: Int]
    let biology: PokeBiology
    
    private enum CodingKeys: String, CodingKey {
        case dexNumber
        case name
        case stats = "base_stats"
        case type
        case abilities
        case evolution
        case biology
    }
}

struct StatArray: Codable {
    let HP: Int
    let ATK: Int
    let DEF: Int
    let SPA: Int
    let SDF: Int
    let SPD: Int
}

struct PokeBiology: Codable {
    let height: PokeHeight
    let weight: PokeWeight
    let maleRatio: Double
    let eggGroup: [EggGroup]
    let hatchRate: Int
    let diet: [DietType]
    let habitat: [Environment]
}

struct PokeHeight: Codable {
    let value: Double
    let sizeClass: SizeClass
}

struct PokeWeight: Codable {
    let value: Double
    let weightClass: Int
}

enum PokeType: String, Codable {
    case grass
    case poison
}

enum AbilityType: String, Codable {
    case basic
    case high
}

enum SizeClass: String, Codable {
    case small
    case medium
    case large
}

enum EggGroup: String, Codable {
    case monster
    case plant
}

enum DietType: String, Codable {
    case carnivore
    case herbivore
    case omnivore
    case phototroph
}

enum Environment: String, Codable {
    case forest
    case grassland
    case rainforest
}
