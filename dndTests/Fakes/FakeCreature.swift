/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

import Foundation

@testable import dnd

extension Creature.Ability {
    static func fake(
        strength: AbilityScore = 1,
        dexterity: AbilityScore = 1,
        constitution: AbilityScore = 1,
        intelligence: AbilityScore = 1,
        wisdom: AbilityScore = 1,
        charisma: AbilityScore = 1
    ) -> Creature.Ability {
        .init(
            strength: strength,
            dexterity: dexterity,
            constitution: constitution,
            intelligence: intelligence,
            wisdom: wisdom,
            charisma: charisma
        )
    }
}

extension Creature.Skill {
    static func fake(
        athletics: Int = 1,
        acrobatics: Int = 1,
        sleightOfHand: Int = 1,
        stealth: Int = 1,
        arcana: Int = 1,
        history: Int = 1,
        investigation: Int = 1,
        nature: Int = 1,
        religion: Int = 1,
        animalHandling: Int = 1,
        insight: Int = 1,
        medicine: Int = 1,
        perception: Int = 1,
        survival: Int = 1,
        deception: Int = 1,
        intimidation: Int = 1,
        performance: Int = 1,
        persuasion: Int = 1
    ) -> Creature.Skill {
        .init(
            athletics: athletics,
            acrobatics: acrobatics,
            sleightOfHand: sleightOfHand,
            stealth: stealth,
            arcana: arcana,
            history: history,
            investigation: investigation,
            nature: nature,
            religion: religion,
            animalHandling: animalHandling,
            insight: insight,
            medicine: medicine,
            perception: perception,
            survival: survival,
            deception: deception,
            intimidation: intimidation,
            performance: performance,
            persuasion: persuasion
        )
    }
}

extension Creature {
    static func fake(
        class: CreatureClass = .wizard,
        level: Int = 1,
        background: CreatureBackground = .sage,
        race: CreatureRace = .highElf,
        size: CreatureSize = .medium,
        alignment: Alignment = .neutral,
        ability: Ability = .fake(),
        savingThrow: Ability = .fake(),
        skill: Skill = .fake(),
        armorClass: Int = 0,
        speed: Int = 0,
        hitPoints: Int = 0
    ) -> Creature {
        .init(
            class: `class`,
            level: level,
            background: background,
            race: race,
            size: size,
            alignment: alignment,
            ability: ability,
            savingThrow: savingThrow,
            skill: skill,
            armorClass: armorClass,
            speed: speed,
            hitPoints: hitPoints
        )
    }
}
