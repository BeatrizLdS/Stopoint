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
    //https://test.api.amadeus.com
    static var urlBase: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "test.api.amadeus.com"
        return components
    }

    // Gera URL para gerar um token de acesso
    //https://test.api.amadeus.com/v1/security/oauth2/token
    static var urlGenerateAcessToken: URL {
        var urlComponents = urlBase
        urlComponents.path = "/v1/security/oauth2/token"
        return urlComponents.url!
    }

    // Url para informação do token existente
    //https://test.api.amadeus.com/v1/security/oauth2/token/<access-token>
    static var urlGetTokenInformation: URL {
        var urlComponents = urlBase
        let token = KeychainHelper.standard.read(service: "access-token", account: "amadeus")!
        let accessToken = String(data: token, encoding: .utf8)!
        urlComponents.path = "/v1/security/oauth2/token/\(accessToken)"
        return urlComponents.url!
    }

    // Url para capturar os voos partindo de fortaleza
    //https://test.api.amadeus.com/v1/airport/direct-destinations?departureAirportCode=FOR
    static var urlAirportRoutes: URL {
        var urlComponents = urlBase
        urlComponents.path = "/v1/airport/direct-destinations"
        urlComponents.query = "departureAirportCode=FOR"
        return urlComponents.url!
    }
}
