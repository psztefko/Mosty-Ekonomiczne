//
//  KeychainWrapper.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation
import Security

final class KeychainWrapper {

    private let suiteName: String

    init(suiteName: String? = nil) {
        self.suiteName = suiteName ?? Bundle.main.bundleIdentifier ?? ""
    }

    @discardableResult func create(key: KeychainKeysNames, data: Data) -> OSStatus {
        remove(key: key)

        let query = [
            kSecAttrService: suiteName,
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecValueData: data
        ] as CFDictionary

        return SecItemAdd(query, nil)
    }

    func load(key: KeychainKeysNames) -> Data? {
        let query = [
            kSecAttrService: suiteName,
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)

        if status == noErr, let data = dataTypeRef as? Data {
            return data
        } else {
            return nil
        }
    }

    func remove(key: KeychainKeysNames) {
        let query = [
            kSecAttrService: suiteName,
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ] as CFDictionary

        SecItemDelete(query)
    }

    func wipeAllEntries() {
        for key in KeychainKeysNames.allCases {
            if key != KeychainKeysNames.configuration {
                remove(key: key)
            }
        }
    }
}
