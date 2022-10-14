//
//  ViewModel.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import Foundation

protocol ViewModelDelegate {
    func fetchAccessToken(token: String)
}

class ViewModel {

    var viewModelDelegate: ViewModelDelegate?
    var account: Account

    init(account: Account) {
        self.account = account
    }

    // Gera um token de aceso para a API e manda para a Controller
    func generateAccessToken() {
        API().generateToken(completion: { result in
            switch result {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    self.account = try JSONDecoder().decode(Account.self, from: data)
                    print(self.account.token)
                    let token = Data(self.account.token.utf8)
                    KeychainHelper.standard.save(data: token, service: "access-token", account: "amadeus")
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }

    // Atualiza o account
    func updateTokenInformation() {
        API().getTokenInformation(completion: { result in
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

    // Função responsável por capturar rotas do aeroporto partindo de Fortaleza
    func getAirportRoutes() {
        self.updateTokenInformation()
        if account.expireTokenTime < 10 {
            self.generateAccessToken()
        }

        API().getRoutes(completion: { result in
            switch result {
            case .success(let data):
                do {
                    let serialization = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(serialization)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }

}
