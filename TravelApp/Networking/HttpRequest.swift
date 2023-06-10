//
//  HttpRequest.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

typealias Parameters = [String: Any]
typealias Headers = [String: String]

class HttpRequest {
    var url: String
    var method: HttpMethod
    var parameters: Parameters
    var headers: Headers

    init(url: String,
         method: HttpMethod,
         parameters: Parameters = [:],
         headers: Headers = HeaderFactory.createHeaders([.token, .language])) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}

enum HeaderType {
    case token
    case language
    case formData(String)
    
    var headerValue: (key: String, value: String) {
        switch self {
        case .token:
            guard let authToken = KeychainWrapper().load(key: .authToken) else {
                return ("", "")
            }
            
            return ("Authorization", "Bearer \(String(data: authToken, encoding: .utf8) ?? "")")
        case .language:
            guard let langCode = Locale.current.languageCode else {
                return ("x-language", "pl")
            }
            
            return ("x-language", langCode)
        case let .formData(boundary):
            return ("Content-Type", "multipart/form-data; boundary=\(boundary)")
        }
    }
}

final class HeaderFactory {

    static func createHeaders(_ types: [HeaderType]) -> Headers {
        var headers: Headers = [:]
        
        for type in types {
            if !type.headerValue.key.isEmpty {
                headers[type.headerValue.key] = type.headerValue.value
            }
        }
        
        return headers
    }
}

