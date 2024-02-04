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
    static let localConfig = Configuration(name: "LOCAL",
                                         serverUrlProtocol: "http",
                                         serverUrlHost: "127.0.0.1:3000")
    static let debugConfig = Configuration(name: "INT",
                                         serverUrlProtocol: "https",
                                         serverUrlHost: "world.openfoodfacts.net/api")
    static let prodConfig = Configuration(name: "PROD",
                                          serverUrlProtocol: "https",
                                          serverUrlHost: "api.prod.travelapp.com")
}

enum Environment {

    static var configuration: Configuration = {
        return .debugConfig
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
            log(.info, .configuration, "Loaded custom configuration: \(customConfiguration)")
            return customConfiguration
        }

        do {
            guard let defaultConfigurationFilePathUrl = Bundle.main.url(forResource: "default", withExtension: "json") else {
                log(.error, .configuration, "configuration missing")
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
