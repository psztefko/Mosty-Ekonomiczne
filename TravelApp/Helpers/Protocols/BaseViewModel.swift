//
//  BaseViewModel.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import SwiftUI

protocol BaseViewModel: AnyObject {
    var defaultErrorDescription: String { get set }
    var apiErrorDescription: String? { get set }
    var apiError: Bool { get set }
    var isLoading: Bool { get set }
    func handleError(_ string: String?)
    func hideError()
    func setLoadingState(_ loadingState: Bool)
}

extension BaseViewModel {
    func handleError(_ string: String?) {
        Task {
            await showError(string)
        }
    }
    
    func hideError() {
        Task {
            await handleHideError()
        }
    }
    
    func setLoadingState(_ loadingState: Bool) {
        Task {
            await changeLoadingState(loadingState)
        }
    }
}

private extension BaseViewModel {
    @MainActor func changeLoadingState(_ loadingState: Bool) {
        withAnimation(.defaultSpring) { [weak self] in
            self?.isLoading = loadingState
        }
    }
    
    @MainActor func handleHideError() {
        withAnimation(.defaultSpring) { [weak self] in
            self?.apiError = false
            self?.apiErrorDescription = nil
        }
    }
    
    @MainActor func showError(_ string: String?) {
        apiErrorDescription = string ?? defaultErrorDescription
        withAnimation(.defaultSpring) {
            setLoadingState(false)
            apiError = true
        }
    }
}
