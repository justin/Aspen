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
public final class LogFormatter: NSObject {
    public var timeFormatter:NSDateFormatter
    
    public override init()
    {
        let locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        timeFormatter = NSDateFormatter()
        timeFormatter.locale = locale
        timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        super.init()
    }
    
    public func formatLog(level: DefaultLogLevel, message: String) -> String
    {
        let logLevel = LogLevel.getLevel(level)
        let levelName = logLevel.label
        let emoji = logLevel.emojiIdentifier()
        let now = NSDate()
        let timeString = timeFormatter.stringFromDate(now)
        
        return "\(timeString) — [\(emoji)\(levelName)\(emoji)] \(message)"
    }
}
