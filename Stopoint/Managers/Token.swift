//
//  Token.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 17/10/22.
//

import Foundation

class Token {

    static var account: Account = Account(clientId: "", token: "", expireTokenTime: 0)

    // Gera um token de aceso para a API e manda para a Controller
    static func generateAccessToken() {
        API().generateToken(completion: { result in
            print(result)
            switch result {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    account = try JSONDecoder().decode(Account.self, from: data)
                    print("Deu bom gerar o toke!\n TOKEN: \(account.token)")
                    let token = Data(account.token.utf8)
                    KeychainHelper.standard.save(data: token, service: "access-token", account: "amadeus")
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    // Atualiza o account
    static func updateTokenInformation() {
        API().getTokenInformation(completion: { result in
            switch result {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    account = try JSONDecoder().decode(Account.self, from: data)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }

    // Função que verifica o token e atualiza caso necessário
    static func verifyToken() {
        self.updateTokenInformation()
        if account.expireTokenTime < 10 {
            self.generateAccessToken()
        }
    }
}
