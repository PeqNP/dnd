/**
 # Combat

 ## Round (= ~6 seconds)

 1. Determine surprise TBD. Many factors may determine if a creature is surprised.
 2. Establish positions TBD. Could place creatures in static position or RNG position.
 3. Roll initiative
 4. Take turns. Each creature takes turn in the initiative order
 5. Begin the next round. Repeat steps 4 and 5 until the fighting stops.

 If a creature is surprised, they can not take a turn in the first round. You also can not take a reaction.

 ## Your Turn
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

 ## Reaction

 An event that triggers at a specific time, such as an Opportunity Attack.
 You may only make one reaction per turn.

 If a reaction inturrupts another creature's turn, they may resume their turn after the reaction.

 A reaction typically triggers immediately at the trigger point unless the reaction says otherwise.
*/

import Foundation

enum DamageType {
    case acid
    case bludgeoning
    case cold
    case fire
    case force
    case lightning
    case ncrotic
    case piercing
    case poison
    case psychic
    case radiation
    case slashing
    case thunder
}

enum CombatAction {
    case help
    case hide
    case ready // Needs more explanation
    case search // Search for a noun - Reveal an invisible Creature
    case useItem // "Use a Magical Item" - Scrolls, potions(?)
    case useObject // "Use an Object" - Throw item(?), interact with something in the environment(?)
    case useSpecialAbility // "Use a Special Ability"
}
