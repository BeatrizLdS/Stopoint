//
//  MockTokenService.swift
//  StopointTests
//
//  Created by Beatriz Leonel da Silva on 24/10/22.
//

import Foundation
@testable import Stopoint

final class MockTokenService: TokenServiceProtocol {
    let mockAccount: [String: Any] = [
        "client_id": "id",
        "expires_in": 20,
        "access_token": "newToken"
    ]

    func generateTokenSuccesData() -> Data {
        var encoded: Data = Data()
        do {
            encoded = try JSONSerialization.data(withJSONObject: mockAccount)
            return encoded
        } catch {
        }
        return encoded
    }

    var result: Result<Data, Error> = .success(Data())

    func generateToken(completion: @escaping (Result<Data, Error>) -> Void) {
        completion(result)
    }

    func getTokenInformation(completion: @escaping (Result<Data, Error>) -> Void) {
        completion(result)
    }
}
