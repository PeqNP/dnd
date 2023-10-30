/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

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
 - Weapon (incl. ranged attacks)
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
 
 If roll = 20, the attack always hits.
 If roll = 1, the attack always misses.
 
 If attacking a Creature you can't see, you have disadvantage. Alternatively, you have advantage if foe can't see you. You lose hidden status when making attack.
 
 #### Cover
 
 Cover provides protection against attacks. If covered by >1, only the greater cover is used. e.g. If behind half Cover and 3/4 Cover, 3/4 Cover is used. Cover only works if directly between you and foe. This may be computed _outside_ of this function and computed as part of Creature's total AC.
 
 Half = +2 AC
 3/4 = +5 AC
 Total = Can't be targeted
 
 #### Ranged Attacks
 
 Any projectile including crossbow, hurling axe, etc. Can only be performed within specified range.
 
 Longbow and shortbow have two ranges. The smaller range is the "normal range." The larger the "long range." Your attack roll has disadvatange if target is beyond "normal range."
 
 Performing range attack in close-combat when for can see you (<=5ft of target), and isn't incapacitated, the roll is done at disadvantage.
 
 #### Melee Attacks
 
 Hand-to-hand combat. A create has 5ft or reach. Some Creatures have >5ft reach, as noted in their descriptions.
 
 Opportunity Attack
 
 Triggered when an enemy you can see leaves your reach. The attack occurs right before the creature leaves your reach. Only one opportunity attack may occur per turn.
 
 You can avoid an opportunity attack by `Disengage`ing, teleporting, or something/someone moves you. e.g. You don't provoke opportunity attack when hurled from explosion.
 
 Grappling
 
 The target may be no more than one size larger than you and must be within your reach. Requires a Grapple check Strength (Athletics) with a DC set by Strength (Athletics) or Dexterity (Acrobatics). The target chooses which to use. You succeed automatically if the target is incapacitated.
 
 Succeeding puts target in a grapple condition.
 
 You may release the target whenever you would like w/o using Action.
 
 Shoving
 
 You may shove a creature to knock it prone or push away from you.
 
 The target must be no more than one size larger than you and within your reach.
 
 You make a Strength (Athletics) check with DC set by a Strength (Athletics) or Dexterity (Acrobatics). Target chooses which to use.
 
 If you succeed, you either knock the target prone or push it 5ft away (your choice).
 
 Unaramed Strikes
 
 On a hit, unarmed strikes deal bludgeoning damage equal to 1 + your Strength modifier.
 
 ## Damage & Healing
 
 ### Hit Points
 
 HP is a combination of physical and mental durability, the will to live, and luck.
 
 HP never goes below 0.
 
 A loss of HP has no affect on a Creature's capabilities until the Creature's HP drops to 0.
 
 ### Damage Rolls
 
 Each weapon, spell, etc. defines a range of damage it deals, if any.
 
 When attacking with a weapon, you add your ability modifier (the same modifier used for the attack roll). A spell tells you which deci to roll for damage and whether to add any modifiers. If a spell, or effect, deals damage to more than one target, roll the damage once for all of them.
 
 ### Critical Hits
 
 When you score a critical hit, you get to roll extra dice for the attack's damage. Roll all attack damage dice twice and add them together. Then add any relevant modifiers.
 
 e.g. If you score critical hit with dagger, roll 2d4, rather than 1d4, and then add relevant ability modifier. If attack involves other dice, such as Sneak Attack, roll those dice twice as well.
 
 ### Damage Types
 
 Refer to `DamageType`. Damage types have no other effect other than factoring in damage resistance.
 
 ### Damage Resistance & Vulnerability
 
 Creatures may be resistant or vulnerable to certain types of damage.
 
 If a Creature is resitant to a type of damage, that damage is halved. If vulnerable, damage is doubled.
 
 All other modifiers to damage, resistance is applied, and then vulnerability. e.g. 25 bludegoning damage is dealt that has bludgeoning resistance. The Creature is also within a magical aura that reduces all damage by 5. The 25 is first reduced by 5, then halved. So the damage would be 10.
 
 If multiple resistances are in play, only one is used. Rather, it only halves once.
 
 ### Healing
 
 Unless it results in death, damage isn't permanent. Even death is reversible through magic.
 
 Rest, magic (`Cure`), can restore a Creature's HP.
 
 HP recovered does _not_ exceed above the Creature's total HP.
 
 A Creature can not regain HP if dead.
 
 #### Dropping to 0 HP
 
 If a Creature reaches 0 HP they either die outright or fall unconscious. e.g. a monster dies if its HP reaches 0, unless the DM decides to treat the monster like a character.
 
 Instant Death - When damage reduced to < 0, the damage remaining is checked against the total HP of the Creature. If it is >= the Creature's HP, it is dead. e.g. If Wizard has max 12 HP, has 6 HP, and takes 18 damage, the wizard's HP is reduced to 0 with 12 remaining damage. The remaing damage == the max HP. Therefore, he is dead.

 Falling Unconscious - If damage reduces a charcter to 0 hit points, and isn't fatal (see above), the character falls unconscious. This ends if the character is healed.

 Death Saving Throws - When unconscious (0 HP), a character throws a death saving throw to determine if they creep closer to death. At beginning of each turn roll a d20. If 3 successive dice are rolled, the character becomes conscious (w/ 1 HP?). If 3 failures, they are dead. The rolls don't need to be consecutive. Keep track of rolls until determined. Both values are reset to zero once the character becomes conscious. If you roll a 1, it counts as two failures. If you roll a 20, you character regains 1 HP.

 Damage at 0 HP - If a character is damaged while having 0 HP, they suffer 1 death saving throw failure. If from a critical hit, 2 failures. If the damage >= their HP, they die instantly (is this cumulative? or should this only count per hit?).

 Stabilizing a Creature - Heal with potions or magic. Or provide first aid, which requires a successful DC 10 Wisdom (Medicine) check. A successful first aid throw stabilizes the Creature but stays at 0 HP. The Creature is no longer required to roll death saving throws. A stable Creature that isn't healed regains 1 HP after 1d4 hours (how is time computed?).

 Knocking a Creature Out - If a Creature reaches 0 HP with a melee attack, the attacker can knock the Creature out.The attacker makes this choice the instant the damage is dealt. The Creature suffers the unconcious condition and is stable (no death saving throws required).

 NOTE: Knocking a Creature out should not be available as an action except in story elements in the game, me thinks. There's no reason otherwise. Such as, you want to bring them alive as a reward for a bounty.

 Harming Objects - Objects have a DC. Objects are immune to poison and psychic damage. DM decides if object is immune / resistant to other types of damage. e.g. It's hard to cut a rope with bludgeoning damage. Objects always fail Strength and Dexterity saving throws and are immune to other effects that require other saves. When an option HP drops to 0, it breaks. A Creature may also make a Strength check to try and break an object. The DC is set by DM.

 ## Mounted Combat

 TODO

 ## Underwater Combat

 TODO

 ## Resting

 Creatures may take 2 short rests / day and a long rest at the end of the day.

 Short Rest - 1 hour long. They may only eat drink, or read. A Creature may spend one or more Hit Dice at the end of a short rest, up to Creature's maximum number of Hit Dice (noted in character sheet or stat block). For each Hit Die spent this way, the player rolls and adds the Creature's Constitution modifier to it. The Creature regains HP equal to the total (min of 0). The player can decide to spend an additional Hit Die after each roll.

 Long Rest - 8 hours. Creature sleeps at least 6 hours and performs no more than 2 hours of light activity such as reading, talking, eating, or standing watch. If rest is interrupted -- at least 1 hour of walking, fighting, casting spells, etc. -- the Creature must restart the rest to gain any benefit. At the end of a long rest, all HP is restored. Creature also regains spent Hit Dice up to half of the Creature's total number of them (round down; min of one dice)(?).
  - I don't quite understand the Hit Dice recovery rule
  - Shouldn't all Hit Die be recovered?
 A Creature must have at least 1 HP to gain long rest benefit.
 A Creature can't benefit from more than one long rest in a 24 hour period. In other words, only one long rest may occur every 24 hours.

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
    // Extended (?) - This may only exist for Creatures have certain Skills.
    
    case disengage // Prevent opportunity attack
    case grapple
    case shove
    
    // Standard
    
    case help
    case hide
    case ready // Wait for trigger to occur before performing action
    case search // Search for a noun - Reveal an invisible Creature
    case useItem // "Use a Magical Item" - Scrolls, potions(?)
    case useObject // "Use an Object" - Throw item(?), interact with something in the environment(?)
    case useSpecialAbility // "Use a Special Ability"
}

/// Represents the types of cover a Creature can take during combat to increase AC. Cover can be provided by an object or another Creature of any size.
enum Cover {
    case half // +2 to AC and Dexterity throws
    case threeQuarters // +5 bonus to AC and Dexterity throws
    case total // Completely covered
}
