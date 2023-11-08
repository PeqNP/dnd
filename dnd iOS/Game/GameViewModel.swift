/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

import Foundation
import SimpleViewModel

class GameViewModel: ViewModel {
    struct ViewState: Equatable {
        
    }
    
    enum Input {
        case didTapNewCharacterButton
    }
    
    enum Output: Equatable {
        case viewState(ViewState)
    }

    func accept(_ input: Input, respond: @escaping (Output) -> Void) {
        
    }
}
