/**
 Encapsulates rules for an outcome of an action.
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

/// A list of Ability actions
/// TODO: This is _very_ incomplete. These actions will be defined as the game progresses.
/// These will eventually be mapped mapped to respective skills. Indeed, these may not be necessary at all. Unclear atm.
enum AbilityAction {
    case acrobaticStunt
    case palmAnObject
    case stayHidden
}

/// Returns the respective Ability, given an Action, to use for an Ability Check.
func abilityForAction(_ action: AbilityAction) -> Ability {
    switch action {
    case .acrobaticStunt,
         .palmAnObject,
         .stayHidden:
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
