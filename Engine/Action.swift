/**
 Encapsulates rules for an outcome of an action.
 
 1 round = ~6 seconds
 
 Combat:
 Round
 1. Determine surprise TBD. Many factors may determine if a creature is surprised.
 2. Establish positions TBD. Could place creatures in static position or RNG position.
 3. Roll initiative
 4. Take turns. Each creature takes turn in the initiative order
 5. Begin the next round. Repeat steps 4 and 5 until the fighting stops.
 
 If a creature is surprised, they can not take a turn in the first round. You also can not take a reaction.

 Your Turn
  - Move
  - Combat Action
     - Attack
     - Cast a Spell
     - Dash - Allows a character to move 2x it Speed e.g. 30 Speed = 60 ft
     - Disengage - Your movement does not provoke opportunity attacks
     - Dodge - Until start of next turn rolls made against you have disadvantage (?) Need more information on how to determine what hits and what does not. This benefit is lost if you received incapicated condition or your speed is reduced to 0 by a condition or another effect (fear?).
     - Help
     - Hide
     - Ready (need more explanation)
     - Search
     - Use a Magic Item - Scrolls, potions(?)
     - Use an Object - throw item(?)
     - Use a Special Ability
  - Communicate (Free)
  - 1st Interact with Things (Free)
  - 2nd Interact with Things (Requires Action, Use an Object) but can use infinite times during turn
  - Do nothing
 
  - Bonus Action. You may only use one Bonus Action type. Therefore, if you have more than one Bonus Action type, only one of those bonus actions may be performed.
  A bonus action can be performed any time. However, some bonus actions define a specific time when they can be used (e.g. the last action) or something else may deprive you of your ability to use a bonus action (I don't know what this means).
 
 Reaction
 An event that triggers at a specific time, such as an Opportunity Attack.
 You may only make one reaction per turn.
 If a reaction inturrupts another creature's turn, they may resume their turn after the reaction.
 A reaction typically triggers immediately at the trigger point unless the reaction says otherwise.
 
 Movement & Position
 Walking, running, jumping, climbing, and swimming. You can move up to your max speed. Your speed is deducted as you move.
 
 A Creature can have a walk and flying speed. A creature may switch between the two speeds.
 1 Speed = 1 Foot
 
 If one of these movement types is 0, the cost of movement is a rate of 2 speed for one foot (movement is halved) 2 Speed = 1 Foot
 - Climbing
 - Crawling
 - Swimming

 If a flying creature is restrained, and does not have the ability to hover, it will "fall." This may incur fall damage.
 
 Difficult terrain costs 3 speed for one foot. (? the rules aren't quite clear)
 
 Jumping
 Long jump (horizontal) is feet equal to your Strength score
 High jump (vertical) 3+ your Strength modifier (not score)
 You must move at least 10ft before these distances can be jumped. If performing standing jump, these distances are halved.
 
 Jumping is deducted similarly to other movement types such as climbing, swimming, etc.
 
 Samples:
 - A harpy has a walking speed of 20, flying speed of 40
   Fly 10, Walk 10, Fly 20 more
   Walk 15, Fly 25 more
 - A badger has walking speed of 30, burrow of 10
   Walk 10, it can no longer burrow
   Burrow 10, Walk 20
 - A human has walking speed of 30, strength of 10
   Jump 10, Walk 20
   Walk 25, Jump 5
 
 Some surfaces may require a successful Strength (Athletics) check. For example, slippery surfaces or one with few handholds.
 */

import Foundation

// MARK: - The D20 roll

func rollAction() {
    /**
     1. Roll d20
     2. Add proficiency bonus (requires creature sheet)
        - (?) Bonsuses don't stack
        - (?) Dis/advantage: Sometimes an dis/advantage occurs on ability check. If this occurs roll the d20 twice. Use higher # if advantage. Lower # if disadvantage.
            - These rolls do not stack. e.g. If you have two advantages, you roll only once.
            - If dis/advantage both occurs, regardless of the number of times, it's as if you have no dis/advantage and roll only one d20.
            - If character has Lucky, they may re-roll both or one of the die. They get to choose which one.
     3. Apply circumstantial bonuses & penalties (feat, spell, or other rule for action)
     4. Compare total against target number. Target number types:
        DC = Difficulty Class
        AC = Armor Class
     */
}

/// Roll for initiative. Used to determine order of turns in combat.
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

// MARK: - (Passive) Perception Check

func rollForPerception() {
    // Compares hiding character's Dexterity (Stealth) with creature's Wisdom Modifier & Perception score and any other bonuses.
    // e.g. Target character has Dexterity 15 (+2 modifier) Stealth (+2) 10 + 2 + 2 = 14
    // e.g. Perceiving character has Wisdom 15 (+2 modifer) Perception (+3) 10 + 2 + 3 = 15
}

// MARK: - Choking

func choke() {
    // 1 + Constitution modifier, minimum of 30 seconds
    // Creature can survive for 1 round + Constitution modifier, minimum of 1 round
    // On next round, its HP drops to 0 and is dying. HP can not be regained or be stabilized until it can breath again
}

// MARK: - Falling

func fallDamage() -> Int {
    // 1d6 bludgeoning damage for every 10 feet it fell, to a maximum of 20d6
    0
}

// MARK: - Ability Check

/**
 Ability check test's a character / monster innate talent and training to overcome a challenge. DM calls for ability check when attempting an action (other than an attack) that has a chance for failure.
 */
func rollAbilityCheck(for ability: Ability) {
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

enum Reaction {
    case opportunityAttack
}

/// A list of Ability actions
/// TODO: This is _very_ incomplete. These actions will be defined as the game progresses.
/// These will eventually be mapped mapped to respective skills. Indeed, these may not be necessary at all. Unclear atm.
enum AbilityAction {
    case jump
    case shove
    case hide
}

/// Returns the respective Ability, given an Action, to use for an Ability Check.
func abilityForAction(_ action: AbilityAction) -> Ability {
    switch action {
    case .shove,
         .jump,
         .hide:
        return .dexterity
    }
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
