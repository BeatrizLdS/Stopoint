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

struct Location: Decodable {
    var iataCode: String?
    var name: String?
}

// Estrutura da cidade
struct City: Decodable {
    let cityCode: String
    let countryCode: String
}
