//
//  Data+JSON.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

extension Data {

    func printFormatedJSON() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            pringJSONData(jsonData)
        }
    }

    func getFormattedJSON() -> String {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
           return String(decoding: jsonData, as: UTF8.self)
        }

        return ""
    }

    private func pringJSONData(_ data: Data) {
        print(String(decoding: data, as: UTF8.self))
    }
}
