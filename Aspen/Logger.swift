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

public final class Logger: NSObject {
	public var level: LogLevel
	public var formatter: LogFormatter

	internal var name: String

	internal var activeLoggers = Array<LogInterface>()

	private let queue = DispatchQueue(label: "com.secondgear.AspenQueue", attributes: [])

	override init() {
		fatalError("Please use init(name:, level:) to initialize a new Logger instance")
	}

	public init(name: String, level: DefaultLogLevel = .info) {
		self.name = name
		self.level = LogLevel.getLevel(level)
		self.formatter = LogFormatter()

		super.init()
	}

	public func registerLogger(_ logger: LogInterface) {
		activeLoggers.append(logger)
	}

	public func setLoggingLevel(_ level: DefaultLogLevel) {
		self.level = LogLevel.getLevel(level)
	}

	func willLog(_ logLevel: DefaultLogLevel) -> Bool {
		return logLevel.rawValue >= level.level.rawValue
	}

	func log(_ logLevel: DefaultLogLevel, message: @autoclosure () -> String) {
        // Don't bother trying to log something with no loggers registered.
		guard activeLoggers.count > 0 else {
			print("*** WARNING: log(\(logLevel.rawValue)) invoked with no loggers registered. If you're expecting file logging for forensic purposes, you're losing data. Message was '\(message())'")
            return
		}

		if self.willLog(logLevel) {
			let constMessage = message()
            
            activeLoggers.forEach { logger in
                queue.async {
                    logger.log(constMessage)
                }
            }
		}
	}

	func logFormatted(_ logLevel: DefaultLogLevel, message: @autoclosure () -> String) {
		log(logLevel, message: formatter.formatLog(logLevel, message: message()))
	}
}

/** Convenience / shorthand logging functions for predefined log levels. */
extension Logger {
	public func verbose( _ message: @autoclosure () -> String) {
		logFormatted(.verbose, message: message)
	}

	public func info( _ message: @autoclosure () -> String) {
		logFormatted(.info, message: message)
	}

	public func warn( _ message: @autoclosure () -> String) {
		logFormatted(.warning, message: message)
	}

	public func error( _ message: @autoclosure () -> String) {
		logFormatted(.error, message: message)
	}
}
