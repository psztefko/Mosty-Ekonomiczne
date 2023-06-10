//
//  KeychainKeysNames.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

enum KeychainKeysNames: String, CaseIterable {
    case authToken
    case configuration

    var rawValue: String {
        switch self {
        case .authToken:
            return "authToken"
        case .configuration:
            return "configuration"
        }
    }
}
