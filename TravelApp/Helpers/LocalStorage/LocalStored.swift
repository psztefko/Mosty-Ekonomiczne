//
//  LocalStored.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

@propertyWrapper
public struct LocalStored<Value: Codable> {

    public var wrappedValue: Value? {
        get {
            guard let repository = repository else {
                let errorMessage = "Trying to get a value without setting a repository!"
                assertionFailure(errorMessage)
                return nil
            }
            return repository.get(forKey: key)
        }
        set {
            guard let repository = repository else {
                let errorMessage = "Trying to set a value without setting a repository!"
                assertionFailure(errorMessage)
                return
            }
            repository.set(value: newValue, forKey: key)
        }
    }

    private let key: KeychainKeysNames
    var repository: LocalStorageRepository?

    init(key: KeychainKeysNames) {
        self.key = key
    }

}

protocol LocalStorageRepository {
    func set<Element: Codable>(value: Element?, forKey key: KeychainKeysNames)
    func get<Element: Codable>(forKey key: KeychainKeysNames) -> Element?
}
