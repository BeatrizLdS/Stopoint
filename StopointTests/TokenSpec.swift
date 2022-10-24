//
//  TokenSpec.swift
//  StopointTests
//
//  Created by Beatriz Leonel da Silva on 23/10/22.
//

import XCTest
@testable import Stopoint

final class TokenSpec: XCTestCase {

    var tokenService: Token!
    var mockTokenService: MockTokenService!

    override func setUp() {
        mockTokenService = MockTokenService()
        tokenService = .init(tokenService: mockTokenService)
    }
    func testGenerateTokenWithCorrectDetailsSetsTokenAccount() {
        mockTokenService.result = .success(mockTokenService.generateTokenSuccesData())
        tokenService.generateAccessToken()
        XCTAssertEqual("newToken", tokenService.account.token)
    }
    func testGenerateTokenWithErrorSetsError() {
        mockTokenService.result = .failure(NSError(domain: "", code: -1, userInfo: nil))
        tokenService.generateAccessToken()
        XCTAssertNotEqual("newToken", tokenService.account.token)
//        XCTAssertNotNil(tokenService.error)
    }
}
