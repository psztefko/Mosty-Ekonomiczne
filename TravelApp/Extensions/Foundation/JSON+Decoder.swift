//
//  JSON+Decoder.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}
