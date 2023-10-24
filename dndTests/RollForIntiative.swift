//
//  RollForIntiative.swift
//  dndTests
//
//  Created by Eric Chamberlain on 10/24/23.
//

import XCTest

@testable import dnd

final class RollForIntiative: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func test_rollWhenCreaturesDoNotHaveSameIniative() throws {
        XCTAssertEqual([Creature](), rollInitiative(for: []))
    }
    
    func test_RollWhenCreaturesHaveSameInitiative() throws {
        XCTAssertEqual([Creature](), rollInitiative(for: []))
    }
}
