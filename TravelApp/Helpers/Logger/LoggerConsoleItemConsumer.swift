//
//  LoggerConsoleItemConsumer.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

public protocol LoggerItemConsumer {
    
    /**
     Implement this method and handle log. This method is called everytime a *log* function is called.
     - Parameters:
        - logItem: an item to be consumed
    */
    func consumeLog(_ logItem: LoggerItem)
    
}

final public class LoggerConsoleItemConsumer: LoggerItemConsumer {
    
    private let consoleFormat: String
    private let dateFormatter = DateFormatManager.shared

    /**
     Initializes console consumer with console format.
     - Parameters:
        - consoleFormat: format to be displayed in the console. Default: *"[level] [[time]] - [module_prefix] [module_name]: [output]"*.
     - Returns: a new console consumer.
    */
    public init(consoleFormat: String = "[level] [[time]] - [module_prefix] [module_name]: [output]") {
        self.consoleFormat = consoleFormat
    }

    public func consumeLog(_ logItem: LoggerItem) {
        print(logItem.toString(consoleFormat, dateFormatter: dateFormatter))
    }
    
}
