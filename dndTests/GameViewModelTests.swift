/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

import Foundation
import XCTest
import SimpleViewModelTest

@testable import dnd

class GameViewModelTests: XCTest {
    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }

    func testViewModel() {
        let tester = TestViewModelInterface(viewModel: GameViewModel())
        tester.send(.didTapNewCharacterButton).expect([])
    }
}
