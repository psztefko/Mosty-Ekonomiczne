//
//  UserRole.swift
//  MostyEkonomiczne
//
//  Created by Patryk Jastrzębski on 25/02/2024.
//

import Foundation

struct UserRole: Codable {
    let name: String
    let city: String
    let icon: String
    let color: String?
}

extension UserRole {
    static let mock = UserRole(name: "Opiekun", city: "Katowice", icon: "🌱", color: nil)
}
