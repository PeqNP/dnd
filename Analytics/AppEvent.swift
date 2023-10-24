/// Copyright ⓒ 2022 Bithead LLC. All rights reserved.

import Foundation

public enum Severity: Int {
    case info
    case warning
    case error
}

struct LogContext {
    let message: String
    let level: LogLevel
    let file: String
    let line: Int
}

enum AppEvent: AnalyticsEvent {
    // Sign In
    case didTapConnectAsGuestButton

    // Logger
    // TODO: These could be moved to the Logger module when modularization happens
    case log(LogContext)
}

extension LogContext {
    func makeProperties() -> [String: String] {
        [
            "file": file,
            "line": String(line),
            "message": message
        ]
    }
}
