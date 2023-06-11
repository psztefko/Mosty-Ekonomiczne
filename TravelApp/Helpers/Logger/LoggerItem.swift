//
//  LoggerItem.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

public struct LoggerItem: Codable {

    /// Automatically incremented index
    public let index: UInt

    /// Date when the log has been created
    public let date: Date

    /// Module used to filter and group logs
    public let module: LoggerModule

    /// One of four available levels (info, success, warning, error) used to filter and group logs
    public let level: LoggerLevel

    /// Stringified log output
    public let output: String
    
}

internal extension LoggerItem {
    
    func toString(_ format: String, dateFormatter: DateFormatManager) -> String {
        
        let currentTime = date
        let date = dateFormatter.string(from: currentTime, format: .dateOnly)
        let time = dateFormatter.string(from: currentTime, format: .timeOnly)
        
        return format.replacingOccurrences(of: "[date]", with: date)
            .replacingOccurrences(of: "[time]", with: time)
            .replacingOccurrences(of: "[level]", with: level.icon)
            .replacingOccurrences(of: "[module_prefix]", with: module.prefix)
            .replacingOccurrences(of: "[module_name]", with: module.name)
            .replacingOccurrences(of: "[output]", with: output)
            .replacingOccurrences(of: "[index]", with: "\(index)")

    }
    
}
