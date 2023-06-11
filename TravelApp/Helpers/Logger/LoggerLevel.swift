//
//  LoggerLevel.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

public enum LoggerLevel: String, Codable, Hashable, CaseIterable {

    /// marked with: 📕
    case error

    /// marked with: 📙
    case warning

    /// marked with: 📗
    case success

    /// marked with: 📘
    case info
    
    internal var icon: String {
        switch self {
        case .error:
            return "📕"
        case .warning:
            return "📙"
        case .success:
            return "📗"
        case .info:
            return "📘"
        }
    }
    
}
