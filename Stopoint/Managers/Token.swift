//
//  Token.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 17/10/22.
//

import Foundation

class Token {
    var account: Account = Account(clientId: "", token: "", expireTokenTime: 0)
    private let tokenService: TokenServiceProtocol

    init(tokenService: TokenServiceProtocol = API()) {
        self.tokenService = tokenService
    }

    // Gera um token de aceso para a API e manda para a Controller
    func generateAccessToken(completion: @escaping (CustomErrors?) -> Void) {
        tokenService.generateToken(completion: { result in
            switch result {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    self.account = try JSONDecoder().decode(Account.self, from: data)
                    let token = Data(self.account.token.utf8)
                    KeychainHelper.standard.save(data: token, service: "access-token", account: "amadeus")
                    completion(nil)
                } catch {
                    completion(.invalidResponse)
                }
            case .failure(let error):
                completion(error)
            }
        })
    }

    // Atualiza o account
    func updateTokenInformation(completion: @escaping (CustomErrors?) -> Void) {
        tokenService.getTokenInformation(completion: { result in
            switch result {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    self.account = try JSONDecoder().decode(Account.self, from: data)
                    completion(nil)
                } catch {
                    completion(.invalidResponse)
                }
            case .failure(let error):
                completion(error)
            }
        })
    }

    // Função que verifica o token e atualiza caso necessário
    func verifyToken(completion: @escaping (CustomErrors?) -> Void) {
        self.updateTokenInformation { error in
            if self.account.expireTokenTime < 10 {
                self.generateAccessToken(completion: completion)
            } else {
                completion(error)
            }
        }
    }
}
