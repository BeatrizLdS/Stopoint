//
//  Token.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 17/10/22.
//

import Foundation

class Token {

    var error: Error?
    var account: Account = Account(clientId: "", token: "", expireTokenTime: 0)
    private let tokenService: TokenServiceProtocol

    init(tokenService: TokenServiceProtocol = API()) {
        self.tokenService = tokenService
    }

    // Gera um token de aceso para a API e manda para a Controller
    func generateAccessToken(completion: @escaping () -> Void) {
        tokenService.generateToken(completion: { result in
            switch result {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    self.account = try JSONDecoder().decode(Account.self, from: data)
                    let token = Data(self.account.token.utf8)
                    KeychainHelper.standard.save(data: token, service: "access-token", account: "amadeus")
                    completion()
                } catch {
                    self.error = error
                    print(error.localizedDescription)
                }
            case .failure(let error):
                self.error = error
                print(error.localizedDescription)
            }
        })
    }

    // Atualiza o account
    func updateTokenInformation() {
        tokenService.getTokenInformation(completion: { result in
            switch result {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    self.account = try JSONDecoder().decode(Account.self, from: data)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }

    // Função que verifica o token e atualiza caso necessário
    func verifyToken() {
        self.updateTokenInformation()
        if self.account.expireTokenTime < 10 {
            self.generateAccessToken(completion: {})
        }
    }
}
