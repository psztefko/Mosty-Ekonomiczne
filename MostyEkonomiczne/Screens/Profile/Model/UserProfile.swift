//
//  UserProfile.swift
//  MostyEkonomiczne
//
//  Created by Patryk Jastrzębski on 25/02/2024.
//

import Foundation

struct UserProfile: Codable {
    let backgroundImageUrl: String
    let profileImageUrl: String
    let name: String
    let lastName: String
    let description: String?
    let role: UserRole
    let contact: [ContactMedia]
}

// swiftlint:disable all

extension UserProfile {
    static let mock = UserProfile(backgroundImageUrl: "https://www.colliers.com/-/media/images/colliers/emea/poland/research/202302reportkatowicehero.ashx?bid=ac08056b8d064555b72f161638f7c032",
                                  profileImageUrl: "https://media.licdn.com/dms/image/D4D03AQErm9Y5q5sCHQ/profile-displayphoto-shrink_800_800/0/1678109390193?e=1714608000&v=beta&t=P1n0PtnpjyCHoj3I3TrXhAZXxg3GwS9FeHWaGU-2WVo",
                                  name: "Piotr",
                                  lastName: "Sztefko",
                                  description: "Jestem Piter taki o 10k ios developer. Pracuję sb a to jest przykładowy opis dla Mostów ekonomicznych hehe.",
                                  role: .mock,
                                  contact: [.messengerMock, .phoneMock])
}
