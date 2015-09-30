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
public enum DefaultLogLevel: Int
{
    case Verbose = 200
    case Info = 300
    case Warning = 400
    case Error = 500
}

@objc
public class LogLevel: NSObject
{
    public var level: DefaultLogLevel
    public var name: String
    public var label: String
    
    internal static let VERBOSE_LEVEL = LogLevel.create(.Verbose, name: "Verbose Level", label: "VERBOSE")
    internal static let INFO_LEVEL = LogLevel.create(.Info, name: "Info Level", label: "INFO")
    internal static let WARNING_LEVEL = LogLevel.create(.Warning, name: "Warning Level", label: "WARN")
    internal static let ERROR_LEVEL = LogLevel.create(.Error,  name: "Error Level", label: "ERROR")
    
    public init(level: DefaultLogLevel, name: String, label: String)
    {
        self.level = level
        self.name = name
        self.label = label
    }
    
    public static func getLevel(level:DefaultLogLevel) -> LogLevel
    {
        switch level
        {
        case .Verbose:
            return VERBOSE_LEVEL
        case .Info:
            return INFO_LEVEL
        case .Warning:
            return WARNING_LEVEL
        case .Error:
            return ERROR_LEVEL
        }
    }
    
    public func emojiIdentifier() -> String
    {
        switch level
        {
        case .Verbose:
            return "🚧"
        case .Info:
            return "☝️"
        case .Warning:
            return "⚠️"
        case .Error:
            return "🚨"
        }
    }
    
   private static func create(level: DefaultLogLevel, name: String, label: String) -> LogLevel
    {
        return LogLevel(level:level, name: name, label: label)
    }
}