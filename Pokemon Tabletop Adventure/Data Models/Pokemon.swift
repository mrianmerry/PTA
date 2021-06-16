//
//  Pokemon.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 16/09/2021.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import Foundation

public struct Pokemon: Codable, Equatable {
    let abilityPassives: [AbilityPassive]
    let biology: Biology
    let book: String
    let evolution: [Evolution]
    let moves: [Move]?
    let name: String
    let pokedexNumber: Int
    let proficiencies: [Proficiency]
    let signatureMoves: [String]
    let size: Size
    let skills: [Skill]
    let statPassives: [StatPassive]
    let stats: Stats
    let types: [Type]
    let weight: Weight
    
    enum CodingKeys: String, CodingKey {
        case biology            = "biology"
        case book               = "book"
        case evolution          = "evolution"
        case name               = "name"
        case moves              = "moves"
        case proficiencies      = "proficiencies"
        case size               = "size"
        case skills             = "skills"
        case stats              = "stats"
        case types              = "types"
        case weight             = "weight"
        case abilityPassives    = "ability_passives"
        case pokedexNumber      = "pokedex_number"
        case signatureMoves     = "signature_moves"
        case statPassives       = "stat_passives"
    }
    
    public static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        let areEqual = lhs.pokedexNumber == rhs.pokedexNumber && lhs.name == rhs.name
        return areEqual
    }
}

public struct Biology: Codable {
    let diet: [Diet]
    let eggGroups: [EggGroup]
    let habitat: [Habitat]
    let hatchRate: Int?
    
    enum CodingKeys: String, CodingKey {
        case diet       = "diet"
        case habitat    = "habitat"
        case eggGroups  = "egg_groups"
        case hatchRate  = "hatch_rate"
    }
}

public struct Evolution: Codable {
    let method: String?
    let pokemon: String
}

public struct Move: Codable {
    let category: MoveCategory
    let damage: String
    let frequency: Frequency
    let name: String
    let notes: String
    let range: String
    let types: [Type]
}

public struct AbilityPassive: Passive, Codable {
    public let description: String
    public let name: String
}

public struct StatPassive: Passive, Codable {
    public let description: String
    public let name: String
}

public struct Skill: Codable {
    let description: String
    let name: String
}

public struct Stats: Codable {
    let attack: Int
    let defense: Int
    let hitPoints: Int
    let specialAttack: Int
    let specialDefense: Int
    let speed: Int
    
    enum CodingKeys: String, CodingKey {
        case attack         = "attack"
        case defense        = "defense"
        case hitPoints      = "hit_points"
        case specialAttack  = "special_attack"
        case specialDefense = "special_defense"
        case speed          = "speed"
    }
}

public protocol Passive {
    var description: String { get }
    var name: String { get }
}

public enum Diet: String, Codable {
    case carnivore      = "Carnivore"
    case ergovore       = "Ergovore"
    case glacievore     = "Glacievore"
    case herbivore      = "Herbivore"
    case nullivore      = "Nullivore"
    case omnivore       = "Omnivore"
    case phototroph     = "Phototroph"
    case pollutivore    = "Pollutivore"
    case psiotroph      = "Psiotroph"
    case psiovore       = "Psiovore"
    case saprophyte     = "Saprophyte"
    case terravore      = "Terravore"
    case variable       = "Variable"
}

public enum EggGroup: String, Codable {
    case amorphous  = "Amorphous"
    case bug        = "Bug"
    case ditto      = "Ditto"
    case dragon     = "Dragon"
    case fairy      = "Fairy"
    case field      = "Field"
    case flying     = "Flying"
    case grass      = "Grass"
    case humanLike  = "Human-Like"
    case mineral    = "Mineral"
    case monster    = "Monster"
    case none       = "None"
    case water1     = "Water 1"
    case water2     = "Water 2"
    case water3     = "Water 3"
}

public enum Frequency: String, Codable {
    case atWill         = "At-Will"
    case oncePerCombat  = "1/combat"
    case oncePerDay     = "1/day"
    case thricePerDay   = "3/day"
}

public enum Habitat: String, Codable {
    case arctic         = "Arctic"
    case badlands       = "Badlands"
    case beach          = "Beach"
    case cave           = "Cave"
    case desert         = "Desert"
    case dimensional    = "Foreign Dimension"
    case field          = "Field"
    case forest         = "Forest"
    case glaciers       = "Glaciers"
    case grasslands     = "Grasslands"
    case jungle         = "Jungle"
    case lakes          = "Lakes"
    case marsh          = "Marsh"
    case meadows        = "Meadows"
    case mountains      = "Mountains"
    case ocean          = "Ocean"
    case oceanAbyss     = "Ocean Abyss"
    case oceanFloors    = "Ocean Floors"
    case oceanReefs     = "Ocean Reefs"
    case orchards       = "Orchards"
    case plains         = "Plains"
    case polar          = "Polar"
    case ponds          = "Ponds"
    case rainforests    = "Rainforests"
    case rivers         = "Rivers"
    case ruins          = "Ruins"
    case savanna        = "Savanna"
    case space          = "Space"
    case swamp          = "Swamp"
    case tundra         = "Tundra"
    case unknown        = "Unknown"
    case urban          = "Urban"
    case urbanAbandoned = "Urban Abandoned"
    case urbanBurial    = "Urban Burial"
    case urbanLab       = "Urban Lab"
    case urbanPlants    = "Urban Plants"
    case urbanRuins     = "Urban Ruins"
    case urbanTemple    = "Urban Temple or Shrine"
    case variable       = "Variable"
    case volcanoes      = "Volcanoes"
    case wetlans        = "Wetlands"
    case woodlands      = "Woodlands"
}

public enum MoveCategory: String, Codable {
    case attack         = "Attack"
    case effect         = "Effect"
    case specialAttack  = "Special Attack"
}

public enum Proficiency: String, Codable {
    case anyMove                = "Any Move"
    case arceus                 = "Arceus can know any move"
    case avian                  = "Avian"
    case blades                 = "Blades"
    case bladesClaws            = "Blades/Claws"
    case bruiser                = "Bruiser"
    case bug                    = "Bug"
    case cutesy                 = "Cutesy"
    case dark                   = "Dark"
    case darkMelee              = "Dark (Melee Attacks)"
    case draconian              = "Draconian"
    case dragon                 = "Dragon"
    case electric               = "Electric"
    case elemental              = "Elemental Attacks"
    case elementalE             = "Elemental Attacks E"
    case elementalEF            = "Elemental Attacks EF"
    case elementalEI            = "Elemental Attacks EI"
    case elementalF             = "Elemental Attacks F"
    case elementalFI            = "Elemental Attacks FI"
    case elementalI             = "Elemental Attacks I"
    case elementalBlast         = "Elemental Blast"
    case energyBlast            = "Energy Blast"
    case fairy                  = "Fairy"
    case fangs                  = "Fangs"
    case fangsNoElectric        = "Fangs (No electric-type moves)"
    case fighting               = "Fighting"
    case fire                   = "Fire"
    case floral                 = "Floral"
    case flying                 = "Flying"
    case ghost                  = "Ghost"
    case glutton                = "Glutton"
    case grass                  = "Grass"
    case grassMelee             = "Grass (Melee Attacks)"
    case grassRanged            = "Grass (Ranged Attacks)"
    case ground                 = "Ground"
    case healer                 = "Healer"
    case hexwork                = "Hexwork"
    case hindering              = "Moves that lower opponent’s stats temporarily"
    case horned                 = "Horned"
    case ice                    = "Ice"
    case iceMelee               = "Ice (Melee attacks)"
    case kicks                  = "Kicks"
    case lepidoteran            = "Lepidopteran"
    case magnetism              = "Magnetism"
    case martial                = "Martial"
    case martialKicks           = "Martial (Kicks)"
    case martialNoElectricIce   = "Martial (No Electric or Ice-type moves)"
    case martialNoIce           = "Martial (No Ice-type moves)"
    case martialNoKicks         = "Martial (No Kicks)"
    case martialNoPunches       = "Martial (No Punches)"
    case martialNoPunchesKicks  = "Martial (No Punches/Kicks)"
    case melee                  = "Melee Attacks"
    case munition               = "Munition"
    case none                   = "None"
    case noneFromAny            = "No Moves from Any"
    case normalBlock            = "Normal Block"
    case parasitic              = "Parasitic"
    case piscean                = "Piscean"
    case piscian                = "Piscian"
    case poison                 = "Poison"
    case poisonMelee            = "Poison (Melee Attacks)"
    case poisonNoAttacks        = "Poison (No attacks)"
    case prickly                = "Prickly"
    case pricklyNoAttacks       = "Prickly (No attacks)"
    case psychic                = "Psychic"
    case psychicAttacks         = "Psychic (Attacks)"
    case psychicEffects         = "Psychic (Effects Only)"
    case psychicRanged          = "Psychic (Ranged attacks)"
    case pulse                  = "Pulse"
    case punches                = "Punches"
    case rock                   = "Rock"
    case sketch                 = "Sketch Only"
    case sound                  = "Sound"
    case spellcraft             = "Spellcraft"
    case stampeding             = "Stampeding"
    case steel                  = "Steel"
    case transformOnly          = "Transform Only"
    case tricky                 = "Tricky"
    case variable               = "Variable Type Lists"
    case water                  = "Water"
    case waterNoAttacks         = "Water (No attacks)"
    case waterRanged            = "Water (Ranged Attacks)"
    case weather                = "Weather"
    case weird                  = "Weird"
    case winged                 = "Winged"
    
    // Errors; remove later
    case errorGrassRangedLower  = "Grass (Ranged attacks)"
}

public enum Size: String, Codable {
    case gigantic   = "Gigantic"
    case huge       = "Huge"
    case large      = "Large"
    case medium     = "Medium"
    case small      = "Small"
    case tiny       = "Tiny"
}

public enum Type: String, Codable {
    case bug        = "Bug"
    case dark       = "Dark"
    case dragon     = "Dragon"
    case electric   = "Electric"
    case fairy      = "Fairy"
    case fighting   = "Fighting"
    case fire       = "Fire"
    case flying     = "Flying"
    case ghost      = "Ghost"
    case grass      = "Grass"
    case ground     = "Ground"
    case ice        = "Ice"
    case normal     = "Normal"
    case poison     = "Poison"
    case psychic    = "Psychic"
    case rock       = "Rock"
    case steel      = "Steel"
    case water      = "Water"
}

public enum Weight: String, Codable {
    case featherweight  = "Featherweight"
    case heavy          = "Heavy"
    case light          = "Light"
    case medium         = "Medium"
    case superweight    = "Superweight"
}
