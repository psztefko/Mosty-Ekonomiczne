//
//  DashboardScreen.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import Foundation
import Combine

final class DashboardViewModelImpl: ObservableObject,
                                    ComplexViewModel,
                                    Userable {
    
    enum DashboardDataType {
        case user
        case data
    }
    
    // MARK: - complexViewModel
    typealias DataType = DashboardDataType
    @Published var complexViewModelData: [DataType: ComplexViewModelData] = [.data: .init(""),
                                                                             .user: .init("")]
    @Published var user: User?
    private let service: DashboardService
    var cancellables = Set<AnyCancellable>()
    
    init(service: DashboardService = DashboardServiceImpl()) {
        self.service = service
        setupUserableBindings()
    }
}
