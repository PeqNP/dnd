/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

import XCTest

@testable import dnd

final class CoinTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func test_coinValuesInDifferentDenominations() throws {
        XCTAssertEqual(CoinType.copper.value(in: .copper, for: 1), Double(1))
        XCTAssertEqual(CoinType.copper.value(in: .silver, for: 1), Double(0.1))
        XCTAssertEqual(CoinType.copper.value(in: .electrum, for: 1), Double(0.02))
        XCTAssertEqual(CoinType.copper.value(in: .gold, for: 1), Double(0.01))
        XCTAssertEqual(CoinType.copper.value(in: .platinum, for: 1), Double(0.001))
        XCTAssertEqual(CoinType.copper.value(in: .platinum, for: 1_000), Double(1))
        
        // We're testing a computation with a table reference. Not much value in that.
    }
}
