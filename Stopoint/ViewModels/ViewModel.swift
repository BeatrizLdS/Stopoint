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
                    let _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    self.account = try JSONDecoder().decode(Account.self, from: data)
                    let token = Data(self.account.token.utf8)
                    KeychainHelper.standard.save(data: token, service: "access-token", account: "amadeus")
                    DispatchQueue.main.async {
                        self.viewModelDelegate?.fetchAccessToken(token: self.account.token)
                    }
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }

    func getTokenInformation() {
        API().getTokenInformation(completion: { result in
            switch result {
            case .success(let data):
                do {
                    let _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    self.account = try JSONDecoder().decode(Account.self, from: data)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
