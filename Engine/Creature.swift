/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

import Foundation

enum CreatureType: Equatable {
    case aberration
    case beast
    case celestial
    case construct
    case dragon
    case elemental
    case fey
    case fiend
    case giant
    case humanoid
    case monstrosity
    case ooze
    case plant
    case undead
}

// TODO:
enum CreatureClass: Equatable {
    case barbarian
    case bard
    case cleric
    case druid
    case fighter
    case monk
    case paladin
    case ranger
    case rogue
    case sorcerer
    case warlock
    case wizard
    
    case artificer
    case bloodHunter
}

// TODO:
enum CreatureBackground: Equatable {
    case sage
}

// TODO:
enum CreatureRace: Equatable {
    case highElf
}

typealias GargantuanSize = Int // Must be a value >= 20

enum CreatureSize: Equatable {
    case tiny // 2.5 sq/ft
    case small // 5 sq/ft
    case medium // 5 sq/ft
    case large // 10 sq/ft
    case huge // 15 sq/ft
    case gargantuan(GargantuanSize) // 20+ sq/ft
}

struct Creature: Equatable {
    struct Ability: Equatable {
        let strength: AbilityScore
        let dexterity: AbilityScore
        let constitution: AbilityScore
        let intelligence: AbilityScore
        let wisdom: AbilityScore
        let charisma: AbilityScore
    }
    
    struct Skill: Equatable {
        // Strength
        let athletics: Int

        // Dexterity
        let acrobatics: Int
        let sleightOfHand: Int
        let stealth: Int

        // Intelligence
        let arcana: Int
        let history: Int
        let investigation: Int
        let nature: Int
        let religion: Int

        // Wisdom
        let animalHandling: Int
        let insight: Int
        let medicine: Int
        let perception: Int
        let survival: Int

        // Charisma
        let deception: Int
        let intimidation: Int
        let performance: Int
        let persuasion: Int
    }
    
    struct Speed {
        let land: Int
        let burrow: Int
        let climb: Int
        let fly: Int
        let swim: Int
    }
    
    let `class`: CreatureClass
    let level: Int
    let background: CreatureBackground
    let race: CreatureRace
    let size: CreatureSize
    let alignment: Alignment
    
    let ability: Ability
    let savingThrow: Ability
    let skill: Creature.Skill
    
    // Base values (?)
    let armorClass: Int
    let speed: Int
    let hitPoints: Int
}
