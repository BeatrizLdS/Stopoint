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
        let heigh = CGFloat(30 * countTraveler!) + 30
        return heigh
    }

    // Retorna o pacote de viagem que possui um determinado index
    func loadCurrentRoute(indexPath: IndexPath) -> TravelPackage {
        self.offers?.offers?[indexPath.row].travelerPricings
        return (self.offers?.offers?[indexPath.row])!
    }

    // Função que pesquisa ofertas de voos mais baratas
    func searchFlighOffers() {
        API().getFlightOffers(flight: self.flight!, completion: {result in
            switch result {
            case .success(let data):
                do {
                    let serialization = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(serialization)
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

    // Função que pega o nome da cidade e localização de cada cidade
    func getCityDetails() {
        let list = offers!.dictionaries!.locations
        for (file) in (list) {
            API().getCityByKeyword(city: file.value) { result in
                switch result {
                case .success(let data):
                    do {
                        _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        let options = try JSONDecoder().decode(Routes.self, from: data)
                        let officialCity = options.routes?.first(where: {$0.iataCode == file.value.cityCode})
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
