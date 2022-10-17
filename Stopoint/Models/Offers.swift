//
//  Offers.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 17/10/22.
//

import Foundation

struct Offers: Decodable {
    var offers: [TravelPackage]?
    var dictionaries: Dictionaries?
    enum CodingKeys: String, CodingKey {
        case dictionaries
        case offers = "data"
    }
}

// Estrutura da informação geral do pacote de viagem
struct TravelPackage: Decodable {
    var itineraries: [Itinerarie]
    var price: Price
    var travelerPricings: [TravelerPricings]
}

// Estrutura do dicionário dos códigos
struct Dictionaries: Decodable {
    let carriers: [String: String]
    let locations: [String: City]
}

// Estrutura da cidade
struct City: Decodable {
    let cityCode: String
    let countryCode: String
}

// Estrura que armazena a rota completa mais detalhada
struct Itinerarie: Decodable {
    var segments: [Segment]?
}

// Estrutura que armazena os valores em uma determinada moeda
struct Price: Decodable {
    var base: String
    var currency: String
    var total: String
}

// Informação de valor de cada passageiro
struct TravelerPricings: Decodable {
    var travelerId: String
    var price: Price
    var travelerType: String
}

// Descrição de cada transição da rota
struct Segment: Decodable {
    var arrival: Airport
    var operating: Operating
    var departure: Airport
}

// Locais da rota + horários e datas
struct Airport: Decodable {
    var atTime: String
    var location: String

    enum CodingKeys: String, CodingKey {
        case atTime = "at"
        case location = "iataCode"
    }
}

// Empresa de avião
struct Operating: Decodable {
    var carrierCode: String
}
