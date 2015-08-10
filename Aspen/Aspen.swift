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
public class Aspen: NSObject
{
    static var globalLogger = Logger(name: "Shared", level: .Info)
    
    public class func registerLogger(logger: LogInterface)
    {
        globalLogger.registerLogger(logger)
    }
    
    public class func setLoggingLevel(level: DefaultLogLevel)
    {
        globalLogger.setLoggingLevel(level)
    }
    
    public class func verbose(message: String)
    {
        globalLogger.verbose(message)
    }
    
    public class func info(message: String)
    {
        globalLogger.info(message)
    }
    
    public class func warn(message: String)
    {
        globalLogger.warn(message)
    }
    
    public class func error(message: String)
    {
        globalLogger.error(message)
    }
    
    public class func getLogger(logName:String, level:DefaultLogLevel) -> Logger
    {
        let logger = Logger(name: logName, level: level)
        logger.activeLoggers += globalLogger.activeLoggers
        return logger
    }
    
}