//
//  ComplexViewModelData.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import Foundation

struct ComplexViewModelData {
    var apiError: Bool
    var isLoading: Bool
    var apiErrorDescription: String?
    let defaultErrorDescription: String
    
    init(apiError: Bool,
         isLoading: Bool,
         apiErrorDescription: String? = nil,
         defaultErrorDescription: String) {
        self.apiError = apiError
        self.isLoading = isLoading
        self.apiErrorDescription = apiErrorDescription
        self.defaultErrorDescription = defaultErrorDescription
    }
    
    init(_ defaultErrorDescription: String = "", isLoading: Bool = false) {
        self.apiError = false
        self.isLoading = isLoading
        self.apiErrorDescription = nil
        self.defaultErrorDescription = defaultErrorDescription
    }
}
