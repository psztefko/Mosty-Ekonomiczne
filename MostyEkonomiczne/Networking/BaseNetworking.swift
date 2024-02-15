//
//  BaseUrl.swift
//  MostyEkonomiczne
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation
import Combine

enum UrlFeaturePath: String {
    case home = "/users"
    case user = "/user"
    case place = "/places"
}

class BaseNetworking {

    private let manager: HttpClient
    internal var baseUrl: String {
        let configuration = Environment.configuration
        return "\(configuration.serverUrlProtocol)://\(configuration.serverUrlHost)\(APIVersion.v1.path)"
    }
    
    internal func getBaseUrlWithVersion(_ version: APIVersion, with path: UrlFeaturePath) -> String {
        let configuration = Environment.configuration
        return "\(configuration.serverUrlProtocol)://\(configuration.serverUrlHost)\(version.path)\(path.rawValue)"
    }

    init(manager: HttpClient = HttpClientImpl.shared) {
        self.manager = manager
    }

    func perform<T: Codable>(_ request: HttpRequest) async throws -> T {
        do {
            return try await manager.perform(request)
        } catch {
            throw error
        }
    }
}
