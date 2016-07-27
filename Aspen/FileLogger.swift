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

public final class FileLogger: NSObject, LogInterface {
    public var fileURL:URL?
    
    private var fileHandle:FileHandle?
    
    public override init() {
        super.init()
        let locale = Locale(localeIdentifier: "en_US_POSIX")
        
        let timeFormatter = DateFormatter()
        timeFormatter.locale = locale
        timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let dateString = timeFormatter.string(from: Date())
        
        let fm = FileManager.default
        let urls = fm.urlsForDirectory(.libraryDirectory, inDomains: .userDomainMask)
        guard let url = urls.last else { return }
        
        if let p = url.path {
            let path = URL.init(fileURLWithPath: "\(p)/Logs/\(dateString).log")
            fileURL = path
            openFile()
        }
    }
    
    deinit {
        closeFile()
    }

    public func log(_ message: String) {
        if let handle = fileHandle {
            handle.seekToEndOfFile()
            let messageWithNewLine = "\(message)\n"
            if let data = messageWithNewLine.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                let exception = tryBlock {
                    handle.write(data)
                }
                if exception != nil {
                    print("Error writing to log file \(exception)")
                }
            }
        }
    }
    
    private func openFile() {
        let fm = FileManager.default
        if let URL = fileURL, filePath = URL.path {
            if fm.fileExists(atPath: filePath) == false {
                do {
                    try fm.createDirectory(at: try! URL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
                } catch _ { }
                fm.createFile(atPath: filePath, contents: nil, attributes: nil)
            }
            
            do {
                fileHandle = try FileHandle(forWritingTo: URL)
            } catch {
                print("Error opening log file \(error)")
                fileHandle = nil
            }
        }
    }
    
    private func closeFile() {
        if let handle = fileHandle {
            handle.closeFile()
        }
        fileHandle = nil
    }

}
