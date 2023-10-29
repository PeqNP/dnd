/**
 # Combat

 ## Round (= ~6 seconds)

 1. Determine surprise TBD. Many factors may determine if a creature is surprised. A DM is responsible if anyone is surprised. One context would be if a Sneak Attack was performed. If neither side is stealthy, they automatically notice each other. If not sneak attacking (yet), a Perception check is performed against Stealth check.
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
     - Ready - Wait for trigger to occur before performing action. Usually when a foe crosses a boundary (line or tile). When preparing a spell, you hold its energy until the trigger occurs. This requires concentration. Therefore, if your concentration is broken, you may not be able to perform the action. A readied spell must have a cast time of 1 turn.
       1. Decide trigger - Foe crosses boundary, steps on item, etc.
       2. Decide action - Perform action when trigger is activated
       3. Player may choose to perform right after trigger, or ignore it
     - Search - Perform Wisdom (Perception) check to find something within a given diameter
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

 ## Making an Attack

 Two attack types:
 - Weapon
 - Spell

 1. Choose a target (Creature, object, or location) within your attack range
 2. Determine modifiers - DM determines if target has cover or whether you have (dis)advantage against the target. Spells, special abilities, and other effects may apply penalties or bonuses to attack roll.
 3. Resolve the attack - Make attack roll. On a hit, you roll damage, unless attack has rules that specify otherwise. Some attacks cause special effects in addition to or instead of damage.

 ### Attack Rolls

 Check if attack hits or misses. Roll d20 and add modifiers. If > then target AC, the attack hits.

 If using weapon, Strength ability modifier is added.
 If using range, Dexterity ability modifier is added.

 d20 + AbilityModifier + Proficiency

 Some spells require an attack roll. Need more information. It says it's in the character sheet but doesn't identify the exact property to use.
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
    case ready // Wait for trigger to occur before performing action
    case search // Search for a noun - Reveal an invisible Creature
    case useItem // "Use a Magical Item" - Scrolls, potions(?)
    case useObject // "Use an Object" - Throw item(?), interact with something in the environment(?)
    case useSpecialAbility // "Use a Special Ability"
}
