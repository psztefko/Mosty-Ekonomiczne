//
//  KeychainRepository.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

enum KeychainManagerError: Error {
    case notFound
    case unknown(status: OSStatus)

    init(status: OSStatus) {
        switch status {
        case -25300:
            self = .notFound
        default:
            self = .unknown(status: status)
        }
    }
}

final class KeychainRepository {

    private let keychainWrapper: KeychainWrapper
    private let jsonEncoder: JSONEncoder
    private let jsonDecoder: JSONDecoder

    init(keychainWrapper: KeychainWrapper = KeychainWrapper(),
         jsonEncoder: JSONEncoder = JSONEncoder(),
         jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.keychainWrapper = keychainWrapper
        self.jsonEncoder = jsonEncoder
        self.jsonDecoder = jsonDecoder
    }

}

extension KeychainRepository: LocalStorageRepository {

    func set<Element: Codable>(value: Element?, forKey key: KeychainKeysNames) {

        guard let newValue = value else {
            remove(key: key)
            return
        }

        do {
            let data = try jsonEncoder.encode(newValue)
            let status = keychainWrapper.create(key: key, data: data)
            guard status == noErr else {
                throw KeychainManagerError(status: status)
            }
//            log(.success, .keyChain, "Saved (\(key)) value: \(newValue)")
        } catch {
            print("error")
//            log(.error, .keyChain, "Error Saving (\(key)) value: \(newValue) error: \(error)")
        }

    }

    func get<Element: Codable>(forKey key: KeychainKeysNames) -> Element? {

        do {
            if let data = keychainWrapper.load(key: key) {
                let value = try jsonDecoder.decode(Element.self, from: data)
//                log(.success, .keyChain, "Loaded (\(key)) value: \(value)")
                return value
            }
        } catch {
            print("error")
        }

        return nil

    }

    func remove(key: KeychainKeysNames) {
        keychainWrapper.remove(key: key)
    }

}
