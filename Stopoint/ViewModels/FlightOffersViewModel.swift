//
//  FlightOffersViewModel.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 17/10/22.
//

import Foundation

class FlightOffersViewModel {

    var flight: Flight?
    var offers: Offers?
    var citysList: [Location] = []
    var delegate: DataDelegate?

    init(flight: Flight? = nil, offers: Offers? = nil) {
        self.flight = flight
        self.offers = offers
    }

    // Variável que determina o número de linhas que vai ter na table
    var numberOfRows: Int? {
        return (self.offers?.offers?.count)
    }

    // Função que retorna a altura da célula
    func getRowHeight(indexPath: IndexPath) -> CGFloat {
        let countTraveler = offers?.offers?[indexPath.row].travelerPricings.count
        let countRoutes = offers?.offers?[indexPath.row].itineraries[0].segments?.count
        var heigh = CGFloat(25 * countTraveler!) + 10 // 6 pelo espaço das linhas
        heigh += CGFloat(30 * countRoutes!) + 10 // Pelas linhas de rota
        heigh += 20 // 20 pela linha com o valor total
        heigh += 30 // 30 pela label de valores
        return heigh
    }

    // Retorna o pacote de viagem que possui um determinado index
    func loadCurrentRoute(indexPath: IndexPath) -> TravelPackage {
        return (self.offers?.offers?[indexPath.row])!
    }

    // Função que gera os dados para a controller
    public func generateDatas() {
        searchFlighOffers()
    }

    // Função que pesquisa ofertas de voos mais baratas
    private func searchFlighOffers() {
        Token().verifyToken() {
            API().getFlightOffers(flight: self.flight!, completion: {result in
                switch result {
                case .success(let data):
                    do {
                        _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        self.offers = try JSONDecoder().decode(Offers.self, from: data)
                        print(self.offers)
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

    // Função que pega o nome da cidade e localização de cada cidade
    private func getCityDetails() {
        let list = offers!.dictionaries!.locations
        for (file) in (list) {
            API().getCityByKeyword(city: file.value) { result in
                switch result {
                case .success(let data):
                    do {
                        _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        let options = try JSONDecoder().decode(Routes.self, from: data)
                        let officialCity = options.routes?.first(where: {$0.iataCode == file.value.cityCode})
                        if officialCity != nil {
                            self.citysList.append(officialCity!)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
