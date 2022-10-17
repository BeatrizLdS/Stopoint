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
                print(error)
            }
        })
    }

    func getDetails() {
        for (file) in (offers!.dictionaries!.locations) {
            API().getLocationByKeyword(keyword: file.key, city: file.value, completion: {result in
                switch result {
                case .success(let data):
                    do {
                        let serialization = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        print(serialization)
//                        self.offers = try JSONDecoder().decode(Offers.self, from: data)
//                        print(self.offers)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
}
