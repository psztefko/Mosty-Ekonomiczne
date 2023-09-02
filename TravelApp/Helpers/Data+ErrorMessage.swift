//
//  Data+ErrorMessage.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import Foundation

extension Data {
    func getErrorMessage() -> String? {
        if let errorMessage = try? JSONDecoder.default.decode(ErrorMessage.self, from: self) {
            return errorMessage.message
        }
        return nil
    }
}

struct ErrorMessage: Codable {
    let message: String
}
