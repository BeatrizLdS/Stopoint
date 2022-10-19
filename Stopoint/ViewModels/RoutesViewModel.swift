//
//  ViewModel.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import Foundation

protocol ViewModelDelegate {
    func fetchDatas()
}

class RoutesViewModel {

    var viewModelDelegate: ViewModelDelegate?
    private var routes: Routes

    init(routes: Routes) {
        self.routes = routes
        self.routes.routes = []
    }

    var numberOfRows: Int? {
        return (self.routes.routes?.count)
    }

    func loadCurrentRoute(indexPath: IndexPath) -> Location {
        return (self.routes.routes?[indexPath.row])!
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
                    self.viewModelDelegate?.fetchDatas()
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }

}
