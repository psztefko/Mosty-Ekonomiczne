//
//  UserCacheService.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import Foundation

protocol UserCacheService {
    func getUser() async throws -> User
}

final class UserCacheServiceImpl: BaseNetworking, UserCacheService {
    func getUser() async throws -> User {
        let request = HttpRequest(url: getBaseUrlWithVersion(.blank, with: .user),
                                  method: .get)
        return try await perform(request)
    }
}
