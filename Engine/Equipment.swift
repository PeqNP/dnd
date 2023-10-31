/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

import Foundation

typealias ArmorClass = Int

/**
 # Equipment
 
 ## Buying & Selling
 
 Equipment sells for half of standard price.
 
 Used armor and weapons, taken from enemies, can rarely be sold for their full value. However, gems, jewelry, and art retain their value.
   - Does this mean there is a "wear" property on equipment that is used to determine the prices of the equipment?
 
 Anyone can equip items, but some require proficiencies to unlock all of the item's functionality. If you lack proficiency in armor, you have a disadvntage on any ability check, saving throw, or attack roll that involves Strength or Dexterity, and you can't cast spells.
 
 Anyone can wield a weapon, but you must have poficiency with it in order to add your proficiency bonus to an attack roll you make with it.
 */

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
    case copper
    case silver
    case electrum
    case gold
    case platinum
    
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
    
    func value(in coinType: CoinType) -> Double {
        type.value(in: coinType, for: amount)
    }

    // TBD: There may be a need to convert one `CoinType` to another. Leaving that for now. It may require an array of `CoinType` denominations. As partial coins may not be returned.
}

enum ArmorCategory {
    case lightArmor
    case mediumArmor
    case heavyArmor
}

enum Advantage {
    case notApplicable
    case yes
    case no
}

enum Armor {
    case leather
    case studdedLeather
    
    case hide
    case chainShirt
    case scaleMail
    case breastplate
    case halfPlate
    
    case ringMail
    case chainMail
    case splint
    case plate
    
    var armorType: ArmorCategory {
        switch self {
        case .leather,
             .studdedLeather:
            return .lightArmor
        case .hide,
             .chainShirt,
             .scaleMail,
             .breastplate,
             .halfPlate:
            return .mediumArmor
        case .ringMail,
             .chainMail,
             .splint,
             .plate:
            return .heavyArmor
        }
    }
    
    var armorClass: ArmorClass {
        switch self {
        case .leather:
            return 11
        case .studdedLeather,
             .hide: // Max 2 (of what?)
            return 12
        case .chainShirt:
            return 13
        case .scaleMail, // Max 2
             .breastplate, // Max 2
             .ringMail:
            return 14
        case .halfPlate: // Max 2
            return 15
        case .chainMail:
            return 16
        case .splint:
            return 17
        case .plate:
            return 18
        }
    }
    
    var donTime: Interval {
        switch armorType {
        case .lightArmor:
            return .minutes(1)
        case .mediumArmor:
            return .minutes(5)
        case .heavyArmor:
            return .minutes(10)
        }
    }
    
    var doffTime: Interval {
        switch armorType {
        case .lightArmor:
            return .minutes(1)
        case .mediumArmor:
            return .minutes(1)
        case .heavyArmor:
            return .minutes(5)
        }
    }
    
    // Returns whether armor has disadvantage on Dexterity (Stealth) checks
    var stealthAdvantage: Advantage {
        switch self {
        case .leather,
             .studdedLeather,
             .hide,
             .chainShirt,
             .breastplate:
            return .notApplicable
        case .scaleMail,
             .halfPlate,
             .ringMail,
             .chainMail,
             .splint,
             .plate:
            return .no
        }
    }
    
    // Returns required strength to move at full speed
    var requiredStrength: Int? {
        switch self {
        case .leather,
             .studdedLeather,
             .hide,
             .chainShirt,
             .scaleMail,
             .breastplate,
             .halfPlate,
             .ringMail:
            return nil
        case .chainMail:
            return 13
        case .splint,
             .plate:
            return 15
        }
    }
    
    var cost: CoinValue {
        switch self {
        case .leather,
             .hide:
            return .init(type: .gold, amount: 10)
        case .studdedLeather:
            return .init(type: .gold, amount: 45)
        case .chainShirt,
             .scaleMail:
            return .init(type: .gold, amount: 50)
        case .breastplate:
            return .init(type: .gold, amount: 400)
        case .halfPlate:
            return .init(type: .gold, amount: 750)
        case .ringMail:
            return .init(type: .gold, amount: 30)
        case .chainMail:
            return .init(type: .gold, amount: 75)
        case .splint:
            return .init(type: .gold, amount: 200)
        case .plate:
            return .init(type: .gold, amount: 1_500)
        }
    }
    
    // Returns weight of armor in pounds
    var weight: Int {
        switch self {
        case .leather:
            return 10
        case .studdedLeather:
            return 13
        case .hide:
            return 12
        case .chainShirt:
            return 20
        case .scaleMail:
            return 45
        case .breastplate:
            return 20
        case .halfPlate:
            return 40
        case .ringMail:
            return 40
        case .chainMail:
            return 55
        case .splint:
            return 60
        case .plate:
            return 65
        }
    }
}
