//
//  Routes.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 14/10/22.
//

import Foundation

struct Routes: Decodable {
    var routes: [Location]?

    enum CodingKeys: String, CodingKey {
        case routes = "data"
    }
}

// Estrutura que armazena a localização
struct Location: Decodable {
    var iataCode: String?
    var name: String?
    var geoCode: GeoCode?
}

// Estrutura da localização geográfica
struct GeoCode: Decodable {
    var latitude: Double?
    var longitude: Double?
}

// Estrutura da cidade
struct City: Decodable {
    let cityCode: String
    let countryCode: String
}
