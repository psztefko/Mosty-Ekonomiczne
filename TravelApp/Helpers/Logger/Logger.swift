//
//  Logger.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

public func log(_ level: LoggerLevel, _ module: LoggerModule, _ value: Any) {
    Logger.shared.log(level, module, value)
}

final class Logger {
    private var logIndex: UInt = 0
    private var consumers: [LoggerItemConsumer] = [LoggerConsoleItemConsumer(consoleFormat: defaultConsoleFormat)]
    
    static let shared = Logger()
    static let loggerDirectoryName = "Logs"
    
    func log(_ level: LoggerLevel, _ module: LoggerModule, _ items: Any?...) {
        log(level: level, module: module, items: items)
    }
}

extension Logger {
    private static let defaultConsoleFormat = "[level] [[time]] - [module_prefix] [module_name]: [output]"
    private func getIndex() -> UInt {
        logIndex += 1
        return logIndex
    }
    
    private func log(level: LoggerLevel, module: LoggerModule, items: [Any?]) {
        
        let logItem = LoggerItem(index: getIndex(), date: Date(), module: module, level: level, output: items.toString)
        
        consumers.forEach { consumer in
            consumer.consumeLog(logItem)
        }
        
    }
}
