//
//  HttpClient.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation
import Combine

protocol HttpClient {
    func perform<T: Decodable>(httpRequest: HttpRequest) async throws -> T
    func perform(imagePath: String) async throws -> Data
}

final class HttpClientImpl: HttpClient {
    static let shared = HttpClientImpl()

    private var urlSesion: URLSession
    private var locale: Locale

    private init(urlSesion: URLSession = .shared, locale: Locale = .current) {
        self.urlSesion = urlSesion
        self.locale = locale
    }

    func perform<T: Decodable>(httpRequest: HttpRequest) async throws -> T {
        guard var urlComponents = URLComponents(string: httpRequest.url) else {
            throw AppErrors.httpError
        }
        urlComponents.queryItems = urlComponents.queryItems != nil ? urlComponents.queryItems : [URLQueryItem]()

        urlComponents.queryItems?.append(URLQueryItem(name: "api_key", value: "3bcb94aef4583a87c26ef9783da2c107"))
        if !(urlComponents.queryItems?.map({ $0.name }).contains("language") ?? false) {
            urlComponents.queryItems?.append(URLQueryItem(name: "language", value: locale.languageCode))
        }

        if httpRequest.method == .get {
            urlComponents.queryItems = urlComponents.queryItems != nil ? urlComponents.queryItems : [URLQueryItem]()
            urlComponents.queryItems?.append(contentsOf: httpRequest.parameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            })
        }

        guard let url = urlComponents.url else {
            throw AppErrors.httpError
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpRequest.method.rawValue

        if httpRequest.method == .post {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: httpRequest.parameters)
        }

        let (data, response) = try await urlSesion.data(for: request)

        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw AppErrors.httpError
        }

        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }

    func perform(imagePath: String) async throws -> Data {
        guard let url = URL(string: imagePath) else {
            throw AppErrors.urlError
        }
        let request = URLRequest(url: url)
        let (data, response) = try await urlSesion.data(for: request)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw AppErrors.httpError
        }
        return data
    }
}

struct EmptyData: Codable {}

struct Responseing: Codable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
