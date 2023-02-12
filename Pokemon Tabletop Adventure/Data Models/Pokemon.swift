//
//  Pokemon.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 08/07/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import Foundation

struct Pokedex: Codable {
    static var cachedPokedex: Pokedex?
    static var empty = Self(pokemon: [])
    let pokemon: [Pokemon]
}

struct Pokemon: Codable, Equatable {
    let biology: Biology
    let evolution: [Evolution]
    let moves: [PokeMove]
    let name: String
    let passives: Passives
    let proficiencies: Proficiency
    let ptaID: Int
    let ptaPage: String
    let size: SizeClass
    let skills: [String]            // Convert to PokeSkill
    let stats: Stats
    let type: [PokeType]
    let weight: WeightClass

    var basicDescription: String {
        return """
        Pokemon: \(name)
        Base Stats:
             HP: \(stats.maxHP)
            ATK: \(stats.attack)
            DEF: \(stats.defence)
            SPA: \(stats.specialAttack)
            SDF: \(stats.specialDefence)
            SPD: \(stats.speed)
        Moves:
            \(moves.isEmpty ? "" : "• \(moves[0].description)")
            \(moves.count > 1 ? "• \(moves[1].description)" : "")
            \(moves.count > 2 ? "• \(moves[2].description)" : "")
        """
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        let areEqual = lhs.ptaID == rhs.ptaID
        return areEqual
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.biology = try container.decode(Biology.self, forKey: .biology)
        self.evolution = try container.decode([Evolution].self, forKey: .evolution)
        self.name = try container.decode(String.self, forKey: .name)
        self.passives = try container.decode(Passives.self, forKey: .passives)
        self.proficiencies = try container.decode(Proficiency.self, forKey: .proficiencies)
        self.ptaID = try container.decode(Int.self, forKey: .ptaID)
        self.ptaPage = try container.decode(String.self, forKey: .ptaPage)
        self.size = try container.decode(SizeClass.self, forKey: .size)
        self.skills = try container.decode([String].self, forKey: .skills)
        self.stats = try container.decode(Stats.self, forKey: .stats)
        self.type = try container.decode([PokeType].self, forKey: .type)
        self.weight = try container.decode(WeightClass.self, forKey: .weight)
        
        let moveNames = try container.decode([String].self, forKey: .moves)
        let moves = PokeMove.cachedMoves ?? [].filter { move in
            moveNames.contains(move.name)
        }
        self.moves = moves
    }
}

struct Biology: Codable {
    let diet: [Diet]
    let eggGroup: [EggGroup]
    let hatchRate: Int
    let habitat: [Environment]
}

struct Contest: Codable {
    enum Category: String, Codable {
        case beauty = "Beauty"
        case clever = "Clever"
        case cool = "Cool"
        case cute = "Cute"
        case tough = "Tough"
    }
    
    enum Effect: String, Codable {
        case appeal = "Appeal"
        case torrential = "Torrential Appeal"
    }
    
    let category: Contest.Category
    let effect: Contest.Effect
}

struct Evolution: Codable {
    let method: String
    let ptaID: Int
    let stage: Int
}

struct Passives: Codable {
    let ability: [String]
    let stat: [String]
}

struct PokeMove: Codable {
    static var cachedMoves: [PokeMove]?
    
    enum Category: String, Codable {
        case attack = "Attack"
        case effect = "Effect"
        case special = "Special Attack"
    }
    
    enum Frequency: String, Codable {
        case atWill = "At-Will"
        case daily = "1/day"
        case encounter = "1/combat"
        case limited = "3/day"
    }
    
    let category: PokeMove.Category
    let contest: Contest
    let damageAmount: Int
    let damageDie: Int
    let effect: String
    let frequency: PokeMove.Frequency
    let name: String
    let range: String
    let type: PokeType
    
    var description: String {
        var descriptionText = "\(name): \(range) \(type.rawValue) \(category.rawValue): \(frequency.rawValue)"
        descriptionText.append(" \(damageAmount > 0 ? "\(damageAmount)d\(damageDie)" : "")\(effect.isEmpty ? "" : "\n\(effect)")")
        return descriptionText
    }
}

struct PokeSkill: Codable {
    let description: String
    let grantedBy: [String]
    let name: String
    let summary: String
}

struct Proficiency: Codable {
    let groups: [String]            // Convert to ProficiencyGroup
    let signature: [String]         // Convert to PokeMove
}

struct Stats: Codable {
    let attack: Int
    let defence: Int
    let maxHP: Int
    let specialAttack: Int
    let specialDefence: Int
    let speed: Int
}

enum Diet: String, Codable {
    case carnivore = "Carnivore"
    case herbivore = "Herbivore"
    case omnivore = "Omnivore"
    case phototroph = "Phototroph"
}

enum EggGroup: String, Codable {
    case grass = "Grass"
    case monster = "Monster"
}

enum Environment: String, Codable {
    case forest = "Forest"
    case jungle = "Jungle"
}

enum PokeType: String, Codable {
    case bug = "Bug"
    case dark = "Dark"
    case dragon = "Dragon"
    case electric = "Electric"
    case fairy = "Fairy"
    case fire = "Fire"
    case fighting = "Fighting"
    case flying = "Flying"
    case ghost = "Ghost"
    case grass = "Grass"
    case ground = "Ground"
    case ice = "Ice"
    case normal = "Normal"
    case poison = "Poison"
    case psychic = "Psychic"
    case rock = "Rock"
    case steel = "Steel"
    case typeless = "Typeless"
    case water = "Water"
}

enum SizeClass: String, Codable {
    case tiny = "Tiny"
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
    case huge = "Huge"
    case gigantic = "Gigantic"
}

enum WeightClass: String, Codable {
    case featherweight = "Featherweight"
    case light = "Light"
    case medium = "Medium"
    case heavy = "Heavy"
    case superweight = "Superweight"
}
