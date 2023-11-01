/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

import Foundation

/**
 # Equipment
 
 ## Buying & Selling
 
 Equipment sells for half of standard price.
 
 Used armor and weapons, taken from enemies, can rarely be sold for their full value. However, gems, jewelry, and art retain their value.
   - Does this mean there is a "wear" property on equipment that is used to determine the prices of the equipment?
 
 Anyone can equip items, but some require proficiencies to unlock all of the item's functionality. If you lack proficiency in armor, you have a disadvntage on any ability check, saving throw, or attack roll that involves Strength or Dexterity, and you can't cast spells.
 
 Anyone can wield a weapon, but you must have poficiency with it in order to add your proficiency bonus to an attack roll you make with it.
 */

typealias ArmorClass = Int

// MARK: - Coins

private let coinTypeValueTable: [CoinType: [CoinType: Double]] = [
    .copper: [
        .copper: 1,
        .silver: 0.1,
        .electrum: 0.02,
        .gold: 0.01,
        .platinum: 0.001
    ],
    .silver: [
        .copper: 10,
        .silver: 1,
        .electrum: 0.2,
        .gold: 0.1,
        .platinum: 0.01
    ],
    .electrum: [
        .copper: 50,
        .silver: 5,
        .electrum: 1,
        .gold: 0.5,
        .platinum: 0.05
    ],
    .gold: [
        .copper: 100,
        .silver: 10,
        .electrum: 2,
        .gold: 1,
        .platinum: 0.1
    ],
    .platinum: [
        .copper: 1_000,
        .silver: 100,
        .electrum: 20,
        .gold: 10,
        .platinum: 1
    ]
]

enum CoinType {
    case copper // cp
    case silver // sp
    case electrum //ep
    case gold // gp
    case platinum // pp
    
    func value(in type: CoinType, for amount: Int) -> Double {
        let amount = Double(amount)
        guard let valueInType = coinTypeValueTable[self]?[type] else {
            log.c("Value for Coin \(self) in type \(type) not configured")
            return 0
        }
        return amount * valueInType
    }
}

/// Encapsulates an amount of coin of a given type
struct CoinValue {
    let type: CoinType
    let amount: Int
    
    static var zero: CoinValue {
        .init(type: .copper, amount: 0)
    }

    func value(in coinType: CoinType) -> Double {
        type.value(in: coinType, for: amount)
    }

    // TBD: There may be a need to convert one `CoinType` to another. Leaving that for now. It may require an array of `CoinType` denominations. As partial coins may not be returned.
}

// MARK: - Armor

struct Armor {
    enum Category {
        case light
        case medium
        case heavy
    }

    let name: String
    let category: Armor.Category
    let armorClass: ArmorClass
    let requiredStrength: Int?
    let stealth: Advantage
    let cost: CoinValue
    let weight: Double

    init(
        name: String,
        category: Armor.Category,
        armorClass: ArmorClass,
        requiredStrength: Int? = nil,
        stealth: Advantage = .notApplicable,
        cost: CoinValue,
        weight: Double
    ) {
        self.name = name
        self.category = category
        self.armorClass = armorClass
        self.requiredStrength = requiredStrength
        self.stealth = stealth
        self.cost = cost
        self.weight = weight
    }
}

extension Armor.Category {
    var donTime: Interval {
        switch self {
        case .light:
            return .minutes(1)
        case .medium:
            return .minutes(5)
        case .heavy:
            return .minutes(10)
        }
    }

    var doffTime: Interval {
        switch self {
        case .light:
            return .minutes(1)
        case .medium:
            return .minutes(1)
        case .heavy:
            return .minutes(5)
        }
    }

    func armorClass(for creature: Creature) -> Int {
        switch self {
        case .light:
            return creature.ability.dexterity.modifier
        case .medium:
            // Can only carry a maximum of 2 dexterity from modifier
            return min(creature.ability.dexterity.modifier, 2)
        case .heavy:
            return 0
        }
    }
}

// MARK: - Standard Armor

extension Armor {

    // MARK: Light Armor

    static var leather: Armor {
        .init(name: "Leather", category: .light, armorClass: 11, cost: .init(type: .gold, amount: 10), weight: 10)
    }

    static var studdedLeather: Armor {
        .init(name: "Studded leather", category: .light, armorClass: 12, cost: .init(type: .gold, amount: 45), weight: 13)
    }

    // MARK: Medium Armor

    static var hide: Armor {
        .init(name: "Hide", category: .medium, armorClass: 12, cost: .init(type: .gold, amount: 10), weight: 12)
    }

    static var chainShirt: Armor {
        .init(name: "Chain shirt", category: .medium, armorClass: 13, cost: .init(type: .gold, amount: 50), weight: 20)
    }

    static var scaleMail: Armor {
        .init(name: "Scale mail", category: .medium, armorClass: 14, stealth: .no, cost: .init(type: .gold, amount: 50), weight: 45)
    }

    static var breastplate: Armor {
        .init(name: "Breastplate", category: .medium, armorClass: 14, cost: .init(type: .gold, amount: 400), weight: 20)
    }

    static var halfPlate: Armor {
        .init(name: "Half plate", category: .medium, armorClass: 15, stealth: .no, cost: .init(type: .gold, amount: 750), weight: 40)
    }

    // MARK: Heavy Armor

    static var ringMail: Armor {
        .init(name: "Ring mail", category: .heavy, armorClass: 14, stealth: .no, cost: .init(type: .gold, amount: 30), weight: 40)
    }

    static var chainMail: Armor {
        .init(name: "Chain mail", category: .heavy, armorClass: 16, requiredStrength: 13, stealth: .no, cost: .init(type: .gold, amount: 75), weight: 55)
    }

    static var splint: Armor {
        .init(name: "Splint", category: .heavy, armorClass: 17, requiredStrength: 15, stealth: .no, cost: .init(type: .gold, amount: 200), weight: 60)
    }

    static var plate: Armor {
        .init(name: "Plate", category: .heavy, armorClass: 18, requiredStrength: 18, stealth: .no, cost: .init(type: .gold, amount: 1_500), weight: 65)
    }
}

// MARK: Weapons

typealias WeaponDamageCondition = (Character) -> Bool

struct Weapon {
    enum Category {
        case simpleMelee
        case martialMelee
        case simpleRanged
        case martialRanged
    }

    struct Damage {
        let dice: Dice
        let type: DamageType

        /// A condition that must be true in order for Damage to take effect. e.g. If additional fire damage is performed, and the target is a plant, it does more damage.
        let condition: WeaponDamageCondition?

        init(
            dice: Dice,
            type: DamageType,
            condition: WeaponDamageCondition? = nil
        ) {
            self.dice = dice
            self.type = type
            self.condition = condition
        }
    }

    enum Property {
        case light
        case finesse
        case thrown(normal: Int, long: Int) // min, max = the range the weapon can be thrown
        case versatile(dice: Dice)
        case ammunition(normal: Int, long: Int)
        case loading
        case twoHanded
        case heavy
        case reach
    }

    let name: String
    let category: Weapon.Category
    let damage: [Weapon.Damage]
    let properties: [Weapon.Property]
    let cost: CoinValue
    let weight: Double

    // Convenience init that allows only one damage type to be provided (most contexts).
    init(
        name: String,
        category: Weapon.Category,
        damage: Weapon.Damage,
        properties: [Weapon.Property],
        cost: CoinValue,
        weight: Double
    ) {
        self.name = name
        self.category = category
        self.damage = [damage]
        self.properties = properties
        self.cost = cost
        self.weight = weight
    }
}

// MARK: - Standard Weapons

extension Weapon {

    // MARK: Simple Melee

    static var club: Weapon {
        .init(name: "Club", category: .simpleMelee, damage: .init(dice: .init(number: 1, sides: 4), type: .bludgeoning), properties: [.light], cost: .init(type: .silver, amount: 1), weight: 2)
    }

    static var dagger: Weapon {
        .init(name: "Dagger", category: .simpleMelee, damage: .init(dice: .init(number: 1, sides: 4), type: .piercing), properties: [.finesse, .light, .thrown(normal: 20, long: 60)], cost: .init(type: .gold, amount: 2), weight: 1)
    }

    static var greatClub: Weapon {
        .init(name: "Greatclub", category: .simpleMelee, damage: .init(dice: .init(number: 1, sides: 8), type: .bludgeoning), properties: [.twoHanded], cost: .init(type: .silver, amount: 2), weight: 10)
    }

    static var handaxe: Weapon {
        .init(name: "Handaxe", category: .simpleMelee, damage: .init(dice: .init(number: 1, sides: 6), type: .slashing), properties: [.light, .thrown(normal: 20, long: 60)], cost: .init(type: .gold, amount: 5), weight: 2)
    }

    static var javelin: Weapon {
        .init(name: "Javelin", category: .simpleMelee, damage: .init(dice: .init(number: 1, sides: 6), type: .piercing), properties: [.thrown(normal: 30, long: 120)], cost: .init(type: .silver, amount: 5), weight: 2)
    }

    static var lightHammer: Weapon {
        .init(name: "Light hammer", category: .simpleMelee, damage: .init(dice: .init(number: 1, sides: 4), type: .bludgeoning), properties: [.light, .thrown(normal: 20, long: 60)], cost: .init(type: .gold, amount: 2), weight: 2)
    }

    static var mace: Weapon {
        .init(name: "Mace", category: .simpleMelee, damage: .init(dice: .init(number: 1, sides: 6), type: .bludgeoning), properties: [], cost: .init(type: .gold, amount: 5), weight: 4)
    }

    static var quarterstaff: Weapon {
        .init(name: "Quarterstaff", category: .simpleMelee, damage: .init(dice: .init(number: 1, sides: 6), type: .bludgeoning), properties: [.versatile(dice: .init(number: 1, sides: 8))], cost: .init(type: .silver, amount: 2), weight: 4)
    }

    static var spear: Weapon {
        .init(name: "Spear", category: .simpleMelee, damage: .init(dice: .init(number: 1, sides: 6), type: .piercing), properties: [.thrown(normal: 20, long: 60), .versatile(dice: .init(number: 1, sides: 8))], cost: .init(type: .gold, amount: 1), weight: 3)
    }

    // MARK: Simple Ranged

    static var lightCrossbow: Weapon {
        .init(name: "Crossbow, light", category: .simpleRanged, damage: .init(dice: .init(number: 1, sides: 8), type: .piercing), properties: [.ammunition(normal: 80, long: 320)], cost: .init(type: .gold, amount: 25), weight: 5)
    }

    static var dart: Weapon {
        .init(name: "Dart", category: .simpleRanged, damage: .init(dice: .init(number: 1, sides: 4), type: .piercing), properties: [.finesse, .thrown(normal: 20, long: 60)], cost: .init(type: .copper, amount: 5), weight: 0.25)
    }

    static var shortbow: Weapon {
        .init(name: "Shortbow", category: .simpleRanged, damage: .init(dice: .init(number: 1, sides: 6), type: .piercing), properties: [.ammunition(normal: 80, long: 320), .twoHanded], cost: .init(type: .gold, amount: 25), weight: 2)
    }

    static var sling: Weapon {
        .init(name: "Sling", category: .simpleRanged, damage: .init(dice: .init(number: 1, sides: 4), type: .bludgeoning), properties: [.ammunition(normal: 30, long: 120)], cost: .init(type: .silver, amount: 1), weight: 0)
    }

    // MARK: Martial Melee

    static var battleaxe: Weapon {
        .init(name: "Battleaxe", category: .martialMelee, damage: .init(dice: .init(number: 1, sides: 8), type: .slashing), properties: [.versatile(dice: .init(number: 1, sides: 10))], cost: .init(type: .gold, amount: 10), weight: 4)
    }

    static var flail: Weapon {
        .init(name: "Flail", category: .martialMelee, damage: .init(dice: .init(number: 1, sides: 8), type: .bludgeoning), properties: [], cost: .init(type: .gold, amount: 10), weight: 2)
    }

    static var greataxe: Weapon {
        .init(name: "Greataxe", category: .martialMelee, damage: .init(dice: .init(number: 1, sides: 12), type: .slashing), properties: [.heavy, .twoHanded], cost: .init(type: .gold, amount: 30), weight: 7)
    }

    static var greatsword: Weapon {
        .init(name: "Greatsword", category: .martialMelee, damage: .init(dice: .init(number: 2, sides: 6), type: .slashing), properties: [.heavy, .twoHanded], cost: .init(type: .gold, amount: 50), weight: 6)
    }

    static var halberd: Weapon {
        .init(name: "Halberd", category: .martialMelee, damage: .init(dice: .init(number: 1, sides: 10), type: .slashing), properties: [.heavy, .reach, .twoHanded], cost: .init(type: .gold, amount: 20), weight: 6)
    }

    static var longsword: Weapon {
        .init(name: "Longsword", category: .martialMelee, damage: .init(dice: .init(number: 1, sides: 8), type: .slashing), properties: [.versatile(dice: .init(number: 1, sides: 10))], cost: .init(type: .gold, amount: 15), weight: 3)
    }

    static var maul: Weapon {
        .init(name: "Maul", category: .martialMelee, damage: .init(dice: .init(number: 2, sides: 6), type: .bludgeoning), properties: [.heavy, .twoHanded], cost: .init(type: .gold, amount: 10), weight: 10)
    }

    static var morningstar: Weapon {
        .init(name: "Morningstar", category: .martialMelee, damage: .init(dice: .init(number: 1, sides: 8), type: .piercing), properties: [], cost: .init(type: .gold, amount: 15), weight: 4)
    }

    static var rapier: Weapon {
        .init(name: "Rapier", category: .martialMelee, damage: .init(dice: .init(number: 1, sides: 8), type: .piercing), properties: [.finesse], cost: .init(type: .gold, amount: 25), weight: 2)
    }

    static var scimitar: Weapon {
        .init(name: "Scimitar", category: .martialMelee, damage: .init(dice: .init(number: 1, sides: 6), type: .slashing), properties: [.finesse, .light], cost: .init(type: .gold, amount: 25), weight: 3)
    }

    static var shortsword: Weapon {
        .init(name: "Shortsword", category: .martialMelee, damage: .init(dice: .init(number: 1, sides: 6), type: .piercing), properties: [.finesse, .light], cost: .init(type: .gold, amount: 10), weight: 2)
    }

    static var trident: Weapon {
        .init(name: "Trident", category: .martialMelee, damage: .init(dice: .init(number: 1, sides: 6), type: .piercing), properties: [.thrown(normal: 20, long: 60), .versatile(dice: .init(number: 1, sides: 8))], cost: .init(type: .gold, amount: 5), weight: 4)
    }

    static var warhammer: Weapon {
        .init(name: "Warhammer", category: .martialMelee, damage: .init(dice: .init(number: 1, sides: 8), type: .bludgeoning), properties: [.versatile(dice: .init(number: 1, sides: 10))], cost: .init(type: .gold, amount: 15), weight: 2)
    }

    // MARK: Martial Ranged

    static var handCrossbow: Weapon {
        .init(name: "Crossbow, hand", category: .martialRanged, damage: .init(dice: .init(number: 1, sides: 6), type: .piercing), properties: [.ammunition(normal: 30, long: 120), .light, .loading], cost: .init(type: .gold, amount: 75), weight: 3)
    }

    static var heavyCrossbow: Weapon {
        .init(name: "Crossbow, heavy", category: .martialRanged, damage: .init(dice: .init(number: 1, sides: 10), type: .piercing), properties: [.ammunition(normal: 100, long: 400), .heavy, .loading, .twoHanded], cost: .init(type: .gold, amount: 50), weight: 18)
    }

    static var longbow: Weapon {
        .init(name: "Longbow", category: .martialRanged, damage: .init(dice: .init(number: 1, sides: 8), type: .piercing), properties: [.ammunition(normal: 150, long: 600), .heavy, .twoHanded], cost: .init(type: .gold, amount: 50), weight: 2)
    }

    // MARK: Improvised

    static func improvised(damageType: DamageType, weight: Double) -> Weapon {
        .init(name: "Improvised", category: .simpleMelee, damage: .init(dice: .init(number: 1, sides: 4), type: damageType), properties: [.thrown(normal: 20, long: 60)], cost: .zero, weight: weight)
    }
}

// MARK: - Adventuring Gear


