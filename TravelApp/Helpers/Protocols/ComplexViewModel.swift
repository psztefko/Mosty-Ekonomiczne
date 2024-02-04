//
//  ComplexViewModel.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import SwiftUI

protocol ComplexViewModel: AnyObject {
    associatedtype DataType: Hashable
    var complexViewModelData: [DataType: ComplexViewModelData] { get set }
    func handleError(_ string: String?, type: DataType)
    func hideError(type: DataType)
    func hideAllErrors()
    func setLoadingState(_ loadingState: Bool, for type: DataType, animated: Bool)
    func getErrorDescription(_ type: DataType) -> String?
    func isLoading(_ type: DataType) -> Bool
    func isError(_ type: DataType) -> Bool
}

extension ComplexViewModel {
    func handleError(_ string: String?, type: DataType) {
        Task {
            await showError(string, type: type)
        }
    }
    
    func hideError(type: DataType) {
        Task {
            await handleHideError(type: type)
        }
    }

    func hideErrors(types: [DataType]) {
        types.forEach { hideError(type: $0) }
    }
    
    func setLoadingState(_ loadingState: Bool, for type: DataType, animated: Bool = true) {
        Task {
            if loadingState {
                await handleHideError(type: type)
            }
            await changeLoadingState(loadingState, type: type, animated: animated)
        }
    }
    
    func getErrorDescription(_ type: DataType) -> String? {
        if complexViewModelData[type]?.apiError ?? false,
           let description = complexViewModelData[type]?.apiErrorDescription {
            return description
        }
        return nil
    }
    
    func getErrorDescription(_ types: [DataType]) -> String? {
        for type in types {
            if complexViewModelData[type]?.apiError ?? false,
               let description = complexViewModelData[type]?.apiErrorDescription {
                return description
            }
        }
        return nil
    }
    
    func getAnyExistingErrorDescription() -> String? {
        if let data = complexViewModelData.first(where: { $0.value.apiError }),
           let description = data.value.apiErrorDescription {
            return description
        }
        return nil
    }
    
    func isAnyDataLoading() -> Bool {
        return complexViewModelData.first(where: { $0.value.isLoading }) != nil
    }
    
    func isLoading(_ type: DataType) -> Bool {
        return complexViewModelData[type]?.isLoading ?? false
    }
    
    func isLoading(_ types: [DataType]) -> Bool {
        return types.first(where: { complexViewModelData[$0]?.isLoading == true }) != nil
    }
    
    func isError(_ type: DataType) -> Bool {
        return complexViewModelData[type]?.apiError ?? false
    }
    
    func isError(_ types: [DataType]) -> Bool {
        types.first(where: { complexViewModelData[$0]?.apiError == true }) != nil
    }
    
    func isAnyError() -> Bool {
        return complexViewModelData.first(where: { $0.value.apiError }) != nil
    }
    
    func hideAllErrors() {
        Task {
            await hideAllErrorsWithAnimation()
        }
    }
    
    @MainActor func apiFunction<ResponseData, RequestData>(data: RequestData,
                                                           on dataType: DataType,
                                                           with method: (RequestData) async throws -> ResponseData,
                                                           stopLoadingWhenCanceled: Bool = true,
                                                           successAction: (@MainActor (_ data: ResponseData) async -> Void)? = nil,
                                                           onFailure: (@MainActor () async -> Void)? = nil) async {
        setLoadingState(true, for: dataType)
        var stopLoading = true
        do {
            let response = try await method(data)
            if let successAction = successAction {
                await successAction(response)
            }
        } catch let AppError.apiError(_, data) {
            handleError(data?.getErrorMessage(), type: dataType)
            if let onFailure = onFailure {
                await onFailure()
            }
        } catch let error as URLError {
            if error.code != URLError.Code.cancelled {
                handleError(nil, type: dataType)
            } else {
                stopLoading = false
            }
            if let onFailure = onFailure {
                await onFailure()
            }
        } catch {
            handleError(nil, type: dataType)
            if let onFailure = onFailure {
                await onFailure()
            }
        }
        
        if stopLoadingWhenCanceled {
            setLoadingState(false, for: dataType)
        } else {
            if stopLoading {
                setLoadingState(false, for: dataType)
            }
        }
    }
}

private extension ComplexViewModel {
    @MainActor func changeLoadingState(_ loadingState: Bool, type: DataType, animated: Bool) {
        withAnimation(animated ? .defaultSpring : nil) {
            complexViewModelData[type]?.isLoading = loadingState
        }
    }
    
    @MainActor func handleHideError(type: DataType) {
        withAnimation(.defaultSpring) {
            complexViewModelData[type]?.apiError = false
            complexViewModelData[type]?.apiErrorDescription = nil
        }
    }
    
    @MainActor func showError(_ string: String?, type: DataType) {
        complexViewModelData[type]?.apiErrorDescription = string ?? complexViewModelData[type]?.defaultErrorDescription
        withAnimation(.defaultSpring) {
            setLoadingState(false, for: type)
            complexViewModelData[type]?.apiError = true
        }
    }
    
    @MainActor func hideAllErrorsWithAnimation() {
        withAnimation(.defaultSpring) {
            for key in complexViewModelData.keys {
                complexViewModelData[key]?.apiError = false
                complexViewModelData[key]?.apiErrorDescription = nil
            }
        }
    }
}
