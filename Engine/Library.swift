/// Copyright ⓒ 2022 Bithead LLC. All rights reserved.

import Foundation

class Library {
    static var randomNumber: (Int, Int) -> Int = { low, high in
        Int.random(in: low..<high)
    }
}
