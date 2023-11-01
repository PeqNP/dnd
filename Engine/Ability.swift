/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

import Foundation

// Each score has a range from 3 - 18
// The highest a player character can have is 20
// Monsters may have a range from 1 - 30
enum Ability {
    case strength // physical power
    case dexterity // agility, reflexes, and balance
    case constitution // endurance
    case intelligence // reasoning and memory
    case wisdom // perceptiveness and intuition
    case charisma // force of personality
}

typealias AbilityScore = Int
typealias AbilityModifier = Int

extension AbilityScore {
    var modifier: AbilityModifier {
        abilityModifier(for: self)
    }
}

/// Ability Score & Modifiers (Proficiency Bonus?)
private let abilityScoreModifier: [AbilityScore: AbilityModifier] = [
    1: -5,
    2: -4,
    3: -4,
    4: -3,
    5: -3,
    6: -2,
    7: -2,
    8: -1,
    9: -1,
    10: 0,
    11: 0,
    12: 1,
    13: 1,
    14: 2,
    15: 2,
    16: 3,
    17: 3,
    18: 4,
    19: 4,
    20: 5,
    21: 5,
    22: 6,
    23: 6,
    24: 7,
    25: 7,
    26: 8,
    27: 8,
    28: 9,
    29: 9,
    30: 10
]

func abilityModifier(for abilityScore: AbilityScore) -> AbilityModifier {
    guard let modifier = abilityScoreModifier[abilityScore] else {
        log.c("Attempting to query a score modifier for an ability score of \(abilityScore)")
        return 0
    }
    return modifier
}
