//
//  Userable.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import Foundation
import Combine

protocol Userable: AnyObject {
    var user: User? { get set }
    @MainActor func loadUser()
    @MainActor func reloadUser() async throws
    var cancellables: Set<AnyCancellable> { get set }
}

extension Userable {
    @MainActor func loadUser() {
        Task { [weak self] in
            self?.user = await UserCache.shared.getUser()
        }
    }
    
    @MainActor func reloadUser() async throws {
        self.user = try await UserCache.shared.fetchUser()
    }
    
    func setupUserableBindings() {
        UserCache.shared.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.user = data
            }
            .store(in: &cancellables)
    }
}
