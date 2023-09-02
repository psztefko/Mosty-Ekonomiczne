//
//  User.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import Foundation

struct User: Codable, Equatable {
    let id: String
    let name: String
    let avatar: String
    let userEmail: EmailData
}
