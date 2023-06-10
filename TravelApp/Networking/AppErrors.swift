//
//  AppErrors.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

enum AppErrors: Error {
    case httpError
    case urlError
    case imageError
    case keychainError
    case missingName
    case missingSessionId
    case missingAccountId
}
