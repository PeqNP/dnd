//
//  CreateType.swift
//  dnd iOS
//
//  Created by Eric Chamberlain on 10/23/23.
//

import Foundation

enum CreatureType {
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
enum CreatureClass {
    case wizard
}

// TODO:
enum CreatureBackground {
    case sage
}

// TODO:
enum CreatureRace {
    case highElf
}

// TODO:
enum CreatureSize {
    case medium
}

struct Creature {
    struct Ability {
        let strength: Int
        let dexterity: Int
        let constitution: Int
        let intelligence: Int
        let wisdom: Int
        let charisma: Int
    }
    
    struct Skill {
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
    let initiative: Int
    let speed: Int
    let hitPoints: Int
}
