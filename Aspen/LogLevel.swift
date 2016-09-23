//    The MIT License (MIT)
//
//    Copyright (c) 2015 Justin Williams
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.

import Foundation

@objc
public enum DefaultLogLevel: Int {
    case verbose = 200
    case info = 300
    case warning = 400
    case error = 500
}

public final class LogLevel {
    public var level: DefaultLogLevel
    public var name: String
    public var label: String
    
    internal static let VERBOSE_LEVEL = LogLevel.makeLevel(level: .verbose, name: "Verbose Level", label: "VERBOSE")
    internal static let INFO_LEVEL = LogLevel.makeLevel(level: .info, name: "Info Level", label: "INFO")
    internal static let WARNING_LEVEL = LogLevel.makeLevel(level: .warning, name: "Warning Level", label: "WARN")
    internal static let ERROR_LEVEL = LogLevel.makeLevel(level: .error,  name: "Error Level", label: "ERROR")
    
    // MARK: Initialization
    // ====================================
    // Initialization
    // ====================================
    public init(level: DefaultLogLevel, name: String, label: String) {
        self.level = level
        self.name = name
        self.label = label
    }
    
    public static func getLevel(_ level:DefaultLogLevel) -> LogLevel {
        switch level {
        case .verbose:
            return VERBOSE_LEVEL
        case .info:
            return INFO_LEVEL
        case .warning:
            return WARNING_LEVEL
        case .error:
            return ERROR_LEVEL
        }
    }
    
    public func emojiIdentifier() -> String {
        switch level {
        case .verbose:
            return "🚧"
        case .info:
            return "☝️"
        case .warning:
            return "⚠️"
        case .error:
            return "🚨"
        }
    }
}

extension LogLevel: Equatable { }
public func ==(lhs: LogLevel, rhs: LogLevel) -> Bool {
    return (lhs.level.rawValue == rhs.level.rawValue)
}


// MARK: Private / Convenience
// ====================================
// Private / Convenience
// ====================================
private extension LogLevel {
    static func makeLevel(level: DefaultLogLevel, name: String, label: String) -> LogLevel {
        return LogLevel(level:level, name: name, label: label)
    }
}
