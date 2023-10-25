//
//  RollForIntiative.swift
//  dndTests
//
//  Created by Eric Chamberlain on 10/24/23.
//

import XCTest

@testable import dnd

final class RollForIntiativeTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func test_rollWhenCreaturesDoNotHaveSameIniative() throws {
        let randomNumbers: [Int] = [
            // Creatures w/ AbilityModifier of 3
            1,  // bard
            10, // barbarian
            
            // Creatures w/ AM of 2
            2,  // druid
            1,  // fighter
            10, // cleric
            
            // Creatures w/ AM of 0 (monk)
            10  // monk
        ]
        var callNumber = -1
        Library.randomNumber = { low, high in
            callNumber += 1
            return randomNumbers[callNumber]
        }
        let creatures: [Creature] = [
            .fake(class: .bard, ability: .fake(dexterity: 16)),
            .fake(class: .druid, ability: .fake(dexterity: 15)),
            .fake(class: .monk, ability: .fake(dexterity: 10)),
            .fake(class: .fighter, ability: .fake(dexterity: 14)),
            .fake(class: .cleric, ability: .fake(dexterity: 14)),
            .fake(class: .barbarian, ability: .fake(dexterity: 16)),
        ]
        let expectedCreatures: [Creature] = [
            .fake(class: .barbarian, ability: .fake(dexterity: 16)),
            .fake(class: .bard, ability: .fake(dexterity: 16)),
            .fake(class: .cleric, ability: .fake(dexterity: 14)),
            .fake(class: .druid, ability: .fake(dexterity: 15)),
            .fake(class: .fighter, ability: .fake(dexterity: 14)),
            .fake(class: .monk, ability: .fake(dexterity: 10)),
        ]
        // describe: roll for initiative
        // it: should return the characters in the correct order
        XCTAssertEqual(expectedCreatures, rollInitiative(for: creatures))
        XCTAssertEqual(callNumber, randomNumbers.count - 1)
    }
    
    func test_RollWhenCreaturesHaveSameInitiative() throws {
        let randomNumbers: [Int] = [
            // Creatures w/ AbilityModifier of 3
            // - First roll
            1,  // bard
            1,  // barbarian
            
            // - Second roll
            1,  // bard
            10, // barbarian
            
            // Creatures w/ AM of 2
            2,  // druid
            1,  // fighter
            10, // cleric
            
            // Creatures w/ AM of 0 (monk)
            10  // monk
        ]
        var callNumber = -1
        Library.randomNumber = { low, high in
            callNumber += 1
            return randomNumbers[callNumber]
        }
        let creatures: [Creature] = [
            .fake(class: .bard, ability: .fake(dexterity: 16)),
            .fake(class: .druid, ability: .fake(dexterity: 15)),
            .fake(class: .monk, ability: .fake(dexterity: 10)),
            .fake(class: .fighter, ability: .fake(dexterity: 14)),
            .fake(class: .cleric, ability: .fake(dexterity: 14)),
            .fake(class: .barbarian, ability: .fake(dexterity: 16)),
        ]
        let expectedCreatures: [Creature] = [
            .fake(class: .barbarian, ability: .fake(dexterity: 16)),
            .fake(class: .bard, ability: .fake(dexterity: 16)),
            .fake(class: .cleric, ability: .fake(dexterity: 14)),
            .fake(class: .druid, ability: .fake(dexterity: 15)),
            .fake(class: .fighter, ability: .fake(dexterity: 14)),
            .fake(class: .monk, ability: .fake(dexterity: 10)),
        ]
        // describe: roll for initiative
        // context: when two creatures roll the same initative value
        // it: should return the characters in the correct order
        XCTAssertEqual(expectedCreatures, rollInitiative(for: creatures))
        // it: should rolle the correct number of times
        // smoke test ensures that we are rolling the correct number of times
        XCTAssertEqual(callNumber, randomNumbers.count - 1)
    }
}
