//
//  FlightOffersViewModel.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 17/10/22.
//

import Foundation

protocol FlightOffersDelegate {
    func updateData()
}

class FlightOffersViewModel {

    var flight: Flight?
    var offers: Offers?
    var delegate: FlightOffersDelegate?

    init(flight: Flight? = nil, offers: Offers? = nil) {
        self.flight = flight
        self.offers = offers
    }

    // Função que pesquisa ofertas de voos mais baratas
    func searchFlighOffers() {
        API().getFlightOffers(flight: self.flight!, completion: {result in
            switch result {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    self.offers = try JSONDecoder().decode(Offers.self, from: data)
                    print(self.offers)
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
