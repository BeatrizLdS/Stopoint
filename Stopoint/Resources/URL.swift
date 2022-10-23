//
//  URL.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import Foundation

// Estrutura que vai conter todas as url's que serão utilizadas
struct Url {

    // Cria o componente base da url
    static var urlBase: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "test.api.amadeus.com"
        return components
    }

    // Gera URL para gerar um token de acesso
    static var urlGenerateAcessToken: URL {
        var urlComponents = urlBase
        urlComponents.path = "/v1/security/oauth2/token"
        return urlComponents.url!
    }

    // Url para informação do token existente
    static var urlGetTokenInformation: URL {
        var urlComponents = urlBase
        let token = KeychainHelper.standard.read(service: "access-token", account: "amadeus")!
        let accessToken = String(data: token, encoding: .utf8)!
        urlComponents.path = "/v1/security/oauth2/token/\(accessToken)"
        return urlComponents.url!
    }

    // Url para capturar os voos partindo de fortaleza
    static var urlAirportRoutes: URL {
        var urlComponents = urlBase
        urlComponents.path = "/v1/airport/direct-destinations"
        urlComponents.query = "departureAirportCode=FOR"
        return urlComponents.url!
    }

    // Gera URL para o consumo da rota de pesquisa de voos mais baratos
    static func getUrlFlightOffersSearch(flight: Flight) -> URL {
        var urlComponents = urlBase
        urlComponents.path = "/v2/shopping/flight-offers"
        let origin = "originLocationCode=\(flight.originLocation)"
        let destination = "&destinationLocationCode=\(flight.destinationLocation)"
        let date = "&departureDate=\(flight.departureDate)"
        let persons = "&adults=\(flight.adults)&children=\(flight.childrens)"
        let othersInformetions = "&nonStop=false&currencyCode=BRL&max=3"
        urlComponents.query = "\(origin)\(destination)\(date)\(persons)\(othersInformetions)"
        print(urlComponents.url!)
        return urlComponents.url!
    }

    //https://test.api.amadeus.com/v1/reference-data/locations/cities?countryCode=BR&keyword=RIO&max=10
    // Gera URL para obter informações dos locais
    static func getUrlLocationByKeyword(city: City) -> URL {
        var urlComponents = urlBase
        urlComponents.path = "/v1/reference-data/locations/cities"
        let country = "countryCode=\(city.countryCode)"
        let keyword = "&keyword=\(city.cityCode)"
        urlComponents.query = "\(country)\(keyword)"
        return urlComponents.url!
    }
}
