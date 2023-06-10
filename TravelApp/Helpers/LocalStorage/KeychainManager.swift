//
//  KeychainManager.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

final class KeychainManager {

    private let repository: LocalStorageRepository

    init(repository: LocalStorageRepository = KeychainRepository()) {
        self.repository = repository
        setupRepositories()
    }

    @LocalStored(key: .configuration) var configuration: Configuration?
}

private extension KeychainManager {

    private func setupRepositories() {
        _configuration.repository = repository
    }

}
