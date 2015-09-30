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
public class Logger: NSObject
{
    public var level: LogLevel
    public var formatter: LogFormatter
    
    internal var name: String
    
    internal var activeLoggers:[LogInterface] = [LogInterface]()
    
    private let queue = dispatch_queue_create("com.secondgear.Aspen", DISPATCH_QUEUE_SERIAL)

    override init()
    {
        fatalError("Please use init(name:, level:) to initialize a new Logger instance")
    }
    
    public init(name: String, level: DefaultLogLevel = .Info)
    {
        self.name = name
        self.level = LogLevel.getLevel(level)
        self.formatter = LogFormatter()
        
        super.init()
    }
    
    public func registerLogger(logger: LogInterface)
    {
        activeLoggers.append(logger)
    }
    
    public func setLoggingLevel(level: DefaultLogLevel)
    {
        self.level = LogLevel.getLevel(level)
    }
    
    public func log(logLevel: DefaultLogLevel, message: String)
    {
        if (logLevel.rawValue >= level.level.rawValue)
        {
            for logger in activeLoggers
            {
                dispatch_async(queue) {
                    logger.log(message)
                }
            }
        }
    }
    
    public func verbose(message: String)
    {
        outputToLog(.Verbose, message: message)
    }
    
    public func info(message: String)
    {
        outputToLog(.Info, message: message)
    }
    
    public func warn(message: String)
    {
        outputToLog(.Warning, message: message)
    }
    
    public func error(message: String)
    {
        outputToLog(.Error, message: message)
    }
    
    // MARK: Private/Convenience
    // ====================================
    // Private/Convenience
    // ====================================
    private func outputToLog(level:DefaultLogLevel, message:String)
    {
        let logLevel = level
        let logMessage = formatter.formatLog(self, level: logLevel, message: message)
        
        log(logLevel, message: logMessage)
    }
}