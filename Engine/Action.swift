/**
 Encapsulates rules for an outcome of an action.
 */

import Foundation

// MARK: - The D20 roll

/// TBD: This may be doing too much.
func rollAttack() {
    /**
     1. Roll d20
     2. Add Proficiency Bonus for Skill (requires creature sheet)
        - (?) Bonuses don't stack
        - (?) Dis/advantage: Sometimes an dis/advantage occurs on ability check. If this occurs roll the d20 twice. Use higher # if advantage. Lower # if disadvantage.
            - These rolls do not stack. e.g. If you have two advantages, you roll only once.
            - If dis/advantage both occurs, regardless of the number of times, it's as if you have no dis/advantage and roll only one d20.
            - If character has Lucky, they may re-roll both or one of the die. They get to choose which one.
     3. Apply circumstantial bonuses & penalties (feat, spell, or other rule for action)
     4. Compare total against target number. Target number types:
        DC = Difficulty Class
        AC = Armor Class
     
     If roll = 20, the attack always hits.
     If roll = 1, the attack always misses.
     
     If attacking a Creature you can't see, you have disadvantage. Alternatively, you have advantage if foe can't see you. You lose hidden status when making attack.
     
     Cover
     Cover provides protection against attacks. If covered by >1, only the greater cover is used. e.g. If behind half Cover and 3/4 Cover, 3/4 Cover is used. Cover only works if directly between you and foe. This may be computed _outside_ of this function and computed as part of Creature's total AC.
     */
}

/**
 Roll for initiative. Used to determine order of turns in combat.
 
 TBD: Not sure if this is where the logic lives, but setting a "Surprised" flag on respective Creatures is required. As Creatures that are surprised can't attack on their first turn.
 */
func rollInitiative(for creatures: [Creature]) -> [Creature] {
    let groups = Dictionary(grouping: creatures, by: { abilityModifier(for: $0.ability.dexterity) })
    let sortedAbilityModifiers: [AbilityModifier] = groups.keys.sorted(by: >)
    var orderedCreatures = [Creature]()
    for abilityModifier in sortedAbilityModifiers {
        guard let creatures = groups[abilityModifier] else {
            log.e("Attempting to access group with invalid AbilityModifier \(abilityModifier) groups \(groups)")
            continue
        }
        let numCreaturesInGroup = creatures.count
        while true {
            let randomNumbers = creatures.map { _ in
                Library.randomNumber(0, 100)
            }
            // All numbers are unique
            if Array(Set(randomNumbers)).count == numCreaturesInGroup {
                let combined = Array(zip(randomNumbers, creatures))
                let ordered = combined.sorted(by: { $0.0 > $1.0 })
                orderedCreatures.append(contentsOf: ordered.map { $0.1 })
                break
            }
        }
    }
    return orderedCreatures
}

// MARK: Perception Check

/**
 Perception checks can be passive or active.
 
 As a Creature walks within the map, a Perception check may trigger automatically if they pass an area of interest. For example, there is a hidden door. There is a DC required to perceive the hidden door. All Creatures within the range of the door will roll a Perception check.
 
 In a board game context, a player must actively state that they are looking for a specific object in a specific location. However, in games, this would probably need to be automatic. For example, walking by an AOI (area of interest), or the user opens a drawer to see if a key is hidden in the clothes.
 */

/**
 Roll a Perception check.
 */
func rollPerceptionCheck(for difficultyClass: DifficultyClass) {
    // Compares hiding character's Dexterity (Stealth) with creature's Wisdom Modifier & Perception score and any other bonuses.
    // e.g. Target character has Dexterity 15 (+2 modifier) Stealth (+2) 10 + 2 + 2 = 14
    // e.g. Perceiving character has Wisdom 15 (+2 modifer) Perception (+3) 10 + 2 + 3 = 15
}

// MARK: Suffocating & Choking

/**
 Determine the number of minutes a Creature can hold its breath (choking, in water, etc).
 
 Breath can be held for a number of minutes equal to 1 + Constitution modifier (min 30 seconds).
 
 When Creature runs out of breath, or choking, they can survive for a number of rounds equal to its Constitution modifier (min 1 round). At the start of its next turn, it drops to 0 HP and is dying. It can't regain HP or be stabilized until it can breath again.
 */
func rollSuffocatingCheck() {
    // 1 + Constitution modifier, minimum of 30 seconds
    // Creature can survive for 1 round + Constitution modifier, minimum of 1 round
    // On next round, its HP drops to 0 and is dying. HP can not be regained or be stabilized until it can breath again
}

// MARK: Hiding

/**
 Check if a creature can hide.
 
 Hiding is determined by:
 - `Light`
 - Whether you are `Obscured` (wall / bush / etc)
 - If another creature is looking directly at you
 - An arbitrary DM's DC value
 
 The DC value may be something that can be computed based on `Light`, `Obscured`, or other factors.
 
 The check's total value becomes the DC for subsequent Wisdom (Perception) checks.
 
 You may lose hiding state by making certain actions (make noise, shout a warning, or making an attack). You may also lose hiding from Wisdom (Perception) checks.
 
 An invisible Creature can always hide.
 */
func rollHidingCheck(/*Creature, Tile, Observing [Creatures], DifficultyClass?*/) -> Bool {
    true
}

/**
 Perform a Perception check.
 
 10 + Creature's Wisdom (Perception) Modifier + Proficiency in Perception
 */
func rollPerceptionCheck(/*Creature*/) {
    
}

// MARK: - Falling

func rollFallDamageCheck() -> Int {
    // 1d6 bludgeoning damage for every 10 feet it fell, to a maximum of 20d6
    0
}

// MARK: - Grappling

/**
 Determine if a Creature may put another Creature in the Grappled condition.
 
 Used also to determine if a target Creature can escape Grappled condition.
 */
func rollGrapple(/*Creature, target: Creature*/) {
    // Creature uses Strength (Athletics) and is checked again ->
    // Target Creature may use Strength (Athletics) or Dexterity (Acrobatics) for DC
}

// MARK: - Ability Check

/**
 Ability check test's a character / monster innate talent and training to overcome a challenge. DM calls for ability check when attempting an action (other than an attack) that has a chance for failure. The DM is also responsible for defining the DC for the check.
 */
func rollAbilityCheck(for ability: Ability, dc difficultyClass: DifficultyClass) {
    /**
     1. Determine Ability to check
     2. Choose Skill that applies to check
        - If character has proficiency in Skill's Ability, add it to roll.
     3. Set the Difficulty Class. Each Ability check requires DC.
     4. Roll the d20
        - Add character's skill proficiency bonus
        - Apply bonuses & penalties
        - If total >= DC, the check is a success

     Working Together:
     Sometimes another character can "Help" another character. The character who is the most proficent for the task rolls, with an advantage roll from the other character. I believe this means both character's roll the dice, and whomever's dice is higher is used.

     - Certain actions may only allow N characters to join. e.g. Threading a needle can only be done by one character. Picking a lock may only be two characters.
     - A character with no proficiency in the Ability can not help.
     */
}

/// Check if a creature can hide. Hiding is determined by `Light`, whether you are `Obscured` (wall / bush / etc), or if another creature is looking directly at you.
func hide() -> Bool {
    true
}

enum Reaction {
    case opportunityAttack
}

/// A list of Ability actions
/// TODO: This is _very_ incomplete. These actions will be defined as the game progresses. Unclear if these are necessary.
enum AbilityAction {
    case jump
    case shove
    case hide
    case interact
}

typealias DifficultyClass = Int

enum TaskDifficulty {
    case veryEasy
    case easy
    case medium
    case hard
    case veryHard
    case nearlyImpossible

    /// Get Difficulty Class (DC) for task difficulty
    var difficultyClass: DifficultyClass {
        switch self {
        case .veryEasy:
            return 5
        case .easy:
            return 10
        case .medium:
            return 15
        case .hard:
            return 20
        case .veryHard:
            return 25
        case .nearlyImpossible:
            return 30
        }
    }
}

/// TODO: Depending on the scenario a task difficulty must be determined. The `scenario` is currently undefined. This function may go away. The rule book states that there are rules to determine the task difficulty depending on the context.
func taskDifficulty(for scenario: Int) -> TaskDifficulty {
    .veryEasy
}

func rollSavingThrow() {
    /**
     1. Determine Ability to use
     2. Set the DC. This is determined by the Effect causing the save. e.g. The DC for a saving throw allowed by a spell is determined by the caster's spellcasting ability modifier + proficiency bonus.
     3. Roll the d20
        - Get proficiency bonus, if any
        - Saving throw proficiency bonus, if any
        - Apply any other bonuses / penalties as usual
        - If total >= DC, it is a success
     */
}
