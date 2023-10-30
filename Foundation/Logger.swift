/// Copyright ⓒ 2020 Bithead LLC. All rights reserved.

import Foundation

public enum LogLevel: Int {
    case debug
    case info
    case warning
    case error
    case critical

    public static func < (a: LogLevel, b: LogLevel) -> Bool {
        return a.rawValue < b.rawValue
    }
}

public var log = Logger(
    name: "dnd",
    format: "%name %filename:%line %level - %message",
    analytics: nil
)

public class Logger {

    private let analytics: AnalyticsPublisher<AppEvent>?

    public let name: String
    public let format: String
    public var level: LogLevel = .info

    public var showName = true
    public var showFileNumber = true

    init(name: String, format: String = "%message", analytics: AnalyticsPublisher<AppEvent>? = nil) {
        self.name = name
        self.format = format
        self.analytics = analytics
    }

    private func formatMessage(_ message: String, level: String, file: String, line: Int) -> String {
        format
            .replacingOccurrences(of: "%name", with: name)
            // Display file name only
            .replacingOccurrences(of: "%filename", with: URL(string: file)?.lastPathComponent ?? "")
            // Displays full path to file
            .replacingOccurrences(of: "%file", with: file)
            .replacingOccurrences(of: "%line", with: String(line))
            .replacingOccurrences(of: "%level", with: level)
            .replacingOccurrences(of: "%message", with: message)
    }

    public func d(_ message: String, file: String = #file, line: Int = #line) {
        guard log.level < .info else {
            return
        }
        //analytics.send(.info(.init(message: message, file: file, line: line)))
        print(formatMessage(message, level: "DEBUG", file: file, line: line))
    }
    
    public func i(_ message: String, file: String = #file, line: Int = #line) {
        guard log.level < .warning else {
            return
        }
        //analytics.send(.info(.init(message: message, file: file, line: line)))
        print(formatMessage(message, level: "INFO", file: file, line: line))
    }

    public func w(_ message: String, file: String = #file, line: Int = #line) {
        guard log.level < .error else {
            return
        }
        analytics?.send(.log(.init(message: message, level: .warning, file: file, line: line)))
        print(formatMessage(message, level: "WARNING", file: file, line: line))
    }

    public func e(_ message: String, file: String = #file, line: Int = #line) {
        guard log.level < .critical else {
            return
        }
        analytics?.send(.log(.init(message: message, level: .error, file: file, line: line)))
        print(formatMessage(message, level: "ERROR", file: file, line: line))
    }
    public func e(_ error: Error, file: String = #file, line: Int = #line) {
        guard log.level < .critical else {
            return
        }
        analytics?.send(.log(.init(message: error.localizedDescription, level: .error, file: file, line: line)))
        print(formatMessage(error.localizedDescription, level: "ERROR", file: file, line: line))
    }
    
    public func c(_ message: String, file: String = #file, line: Int = #line) {
        analytics?.send(.log(.init(message: message, level: .error, file: file, line: line)))
        print(formatMessage(message, level: "CRITICAL", file: file, line: line))
    }

    public func strongSelf(file: String = #file, line: Int = #line) {
        e("\(name) - Could not get reference to strong self", file: file, line: line)
    }

    public func nib(file: String = #file, line: Int = #line) {
        e("\(name) - Could not load nib", file: file, line: line)
    }
}
