//
//  Environment.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

enum EnvironmentError: Error {
    case defaultConfigurationFileMissing
}

struct Configuration: Codable {
    let name: String
    let serverUrlProtocol: String
    let serverUrlHost: String
}

extension Configuration {
    static let localConfig = Configuration(name: "INT",
                                         serverUrlProtocol: "https",
                                         serverUrlHost: "api.int.travelapp.com")
    static let debugConfig = Configuration(name: "INT",
                                         serverUrlProtocol: "https",
                                         serverUrlHost: "api.int.travelapp.com")
    static let prodConfig = Configuration(name: "PROD",
                                          serverUrlProtocol: "https",
                                          serverUrlHost: "api.int.travelapp.com")
}

enum Environment {

    static var configuration: Configuration = {
        return loadConfiguration()
    }()

    static func saveConfiguration(configuration: Configuration?, keychainManager: KeychainManager = KeychainManager()) {
        keychainManager.configuration = configuration
        Self.configuration = loadConfiguration()
        debugPrint("Saved configuration: \(String(describing: configuration))")
    }
}

private extension Environment {

    private static func loadConfiguration(keychainManager: KeychainManager = KeychainManager(),
                                          decoder: JSONDecoder = JSONDecoder(),
                                          fileManager: FileManager = FileManager()) -> Configuration {

        if let customConfiguration = keychainManager.configuration {
            debugPrint("Loaded custom configuration: \(customConfiguration)")
            return customConfiguration
        }

        do {
            guard let defaultConfigurationFilePathUrl = Bundle.main.url(forResource: "default", withExtension: "json") else {
                throw EnvironmentError.defaultConfigurationFileMissing
            }
            let defaultConfigurationFileContent = try Data(contentsOf: defaultConfigurationFilePathUrl)
            let defaultConfiguration = try decoder.decode(Configuration.self, from: defaultConfigurationFileContent)
            return defaultConfiguration
        } catch {
            fatalError("Loading default configuration failed: \(error)")
        }
    }
}
