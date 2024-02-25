//
//  ContactMediaIcon.swift
//  MostyEkonomiczne
//
//  Created by Patryk Jastrzębski on 25/02/2024.
//

import SwiftUI

enum ContactMediaIcon: String, Codable {
    case messenger, twitter, phoneNumber
}

extension ContactMediaIcon {
    var name: String? {
        switch self {
        case .messenger:
            return Icons.messenger.name
        case .twitter:
            return nil
        case .phoneNumber:
            return Icons.phone.name
        }
    }
}
