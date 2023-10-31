/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

import Foundation

enum Interval: CaseIterable {
    case seconds(Int)
    case minutes(Int)
    case hours(Int)
    
    static var allCases: [Interval] {
        return [
            .seconds(0),
            .minutes(0),
            .hours(0)
        ]
    }

    var toString: String {
        switch self {
        case .hours(let value):
            return "\(value)h"
        case .minutes(let value):
            return "\(value)m"
        case .seconds(let value):
            return "\(value)s"
        }
    }
}
