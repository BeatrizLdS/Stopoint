//
//  ViewModel.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import Foundation

class RoutesViewModel {

    var delegate: DataDelegate?
    private var routes: Routes

    init(routes: Routes) {
        self.routes = routes
        self.routes.routes = []
    }

    // Variável que determina o número de linhas que vai ter na table
    var numberOfRows: Int? {
        return (self.routes.routes?.count)
    }

    // Retorna a rota que possui um determinado index
    func loadCurrentRoute(indexPath: IndexPath) -> Location {
        return (self.routes.routes?[indexPath.row])!
    }

    // Função responsável por capturar rotas do aeroporto partindo de Fortaleza
    func getAirportRoutes() {
        Token.generateAccessToken()

        API().getRoutes(completion: { result in
            switch result {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    self.routes = try JSONDecoder().decode(Routes.self, from: data)
                    self.delegate?.updateDatas()
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

}
