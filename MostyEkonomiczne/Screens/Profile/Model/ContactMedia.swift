//
//  ContactMedia.swift
//  MostyEkonomiczne
//
//  Created by Patryk Jastrzębski on 25/02/2024.
//

import Foundation

struct ContactMedia: Codable, Identifiable {
    var id = UUID().uuidString
    let icon: ContactMediaIcon
    let name: String
    let url: String?
}

extension ContactMedia {
    static let messengerMock = ContactMedia(icon: .messenger, name: "@piotrek.sztefkoXD123", url: "")
    static let phoneMock = ContactMedia(icon: .phoneNumber, name: "+48 512 532 523", url: "")
}
