//
//  Logger.swift
//  RevivalPatient
//
//  Created by Văn Tiến Tú on 14/12/2021.
//

import UIKit


class Logger {
    public enum LogLevel: String {
        case debug = "DEBUG"
        case info = "INFO"
        case warning = "WARNING"
        case error = "ERROR"
    }
    
    public static let TAG: String = "NALog"
    #if DEBUG
    private static let isDebug = true
    #else
    private static let isDebug = false
    #endif
    
    public static func debug(_ object: Any?,
                             tag: String? = nil,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line) {
        self.print(tag: tag ?? TAG, level: .debug, message: String(describing: object ?? "nil"), file: file, function: function, line: line)
    }
    
    public static func info(_ object: Any?,
                             tag: String? = nil,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line) {
        self.print(tag: tag ?? TAG, level: .info, message: String(describing: object ?? "nil"), file: file, function: function, line: line)
    }
    
    public static func warning(_ object: Any?,
                             tag: String? = nil,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line) {
        self.print(tag: tag ?? TAG, level: .warning, message: String(describing: object ?? "nil"), file: file, function: function, line: line)
    }
    
    public static func error(_ object: Any?,
                             tag: String? = nil,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line) {
        self.print(tag: tag ?? TAG, level: .error, message: String(describing: object ?? "nil"), file: file, function: function, line: line)
    }
    
    private static func print(tag: String?,
                              level: LogLevel,
                              message: String?,
                              file: String = #file,
                              function: String = #function,
                              line: Int = #line) {
        if isDebug {
            let filename = (file as NSString).lastPathComponent
            let threadName: String = Thread.isMainThread ?
                "MAIN" :
                "BG"
            NSLog("[%@] [%@] %@:%@ %@ - %@: \n%@", threadName, level.rawValue, filename, String(line), function, tag ?? TAG, message ?? "")
        }
    }
}
