//
//  EmailStatus.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import Foundation

struct EmailData: Codable, Equatable {
    let email: String
    let status: EmailStatus
}

enum EmailStatus: String, Codable {
    case verified = "VERIFIED"
    case notVerified = "NOT_VERIVIED"
}
