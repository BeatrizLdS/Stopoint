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
    var routes: Routes?

    init(routes: Routes? = nil) {
        self.routes = routes
    }

    // Função responsável por capturar rotas do aeroporto partindo de Fortaleza
    func getAirportRoutes() {
        Token.verifyToken()

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
