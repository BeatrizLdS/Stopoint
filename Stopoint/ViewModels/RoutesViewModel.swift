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

class RoutesViewModel {

    var viewModelDelegate: ViewModelDelegate?
    var account: Account
    var routes: Routes?

    init(account: Account, routes: Routes? = nil) {
        self.account = account
        self.routes = routes
    }

    // Gera um token de aceso para a API e manda para a Controller
    func generateAccessToken() {
        API().generateToken(completion: { result in
            switch result {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    self.account = try JSONDecoder().decode(Account.self, from: data)
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

    // Função que verifica o token e atualiza caso necessário
    func verifyToken() {
        self.updateTokenInformation()
        if account.expireTokenTime < 10 {
            self.generateAccessToken()
        }
    }

    // Função responsável por capturar rotas do aeroporto partindo de Fortaleza
    func getAirportRoutes() {
        verifyToken()

        API().getRoutes(completion: { result in
            switch result {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    self.routes = try JSONDecoder().decode(Routes.self, from: data)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }

}