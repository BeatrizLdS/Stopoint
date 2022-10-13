//
//  ViewModel.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import Foundation



class ViewModel {

    func generateAccessToken() {
        API().generateToken(completion: { result in
            switch result {
            case .success(let data):
                do {
                    let serialization = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(serialization)
                    let account = try JSONDecoder().decode(Authorization.self, from: data)
                    print(account.token)
                    let token = Data(account.token.utf8)
                    KeychainHelper.standard.save(data: token, service: "access-token", account: "amadeus")
                } catch {
                    print(error)
                }
            case .failure(let error):
                print("Caiu nesse erro!")
                print(error)
            }
        })
    }
}
