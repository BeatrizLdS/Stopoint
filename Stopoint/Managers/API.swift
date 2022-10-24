//
//  API.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import Foundation

protocol TokenServiceProtocol {
    func generateToken(completion: @escaping (Result<Data, Error>) -> Void)
    func getTokenInformation(completion: @escaping (Result<Data, Error>) -> Void)
}

// Requisições relacionadas com as rotas (origem -> destino) / Origem = Fortaleza
class API {
    // função responsável por pegar todas as rotas partindo de Fortaleza
    func getRoutes(completion: @escaping (Result<Data, Error>) -> Void) {
        let token = KeychainHelper.standard.read(service: "access-token", account: "amadeus")!
        let accessToken = String(data: token, encoding: .utf8)!
        let url = Url.urlAirportRoutes
        var request = URLRequest(url: url)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        executeRequest(urlRequest: request, completion: completion)
    }

    // Função que executa pesquisa de voos mais baratos para uma ocnfiguração de voo
    func getFlightOffers(flight: Flight, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = Url.getUrlFlightOffersSearch(flight: flight)
        var request = URLRequest(url: url)
        let token = KeychainHelper.standard.read(service: "access-token", account: "amadeus")!
        let accessToken = String(data: token, encoding: .utf8)!
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        executeRequest(urlRequest: request, completion: completion)
    }

    // Função que busca descrição de códigos de lugares
    func getCityByKeyword(city: City, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = Url.getUrlLocationByKeyword(city: city)
        var request = URLRequest(url: url)
        let token = KeychainHelper.standard.read(service: "access-token", account: "amadeus")!
        let accessToken = String(data: token, encoding: .utf8)!
        request.addValue("application/vnd.amadeus+json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        executeRequest(urlRequest: request, completion: completion)
    }

    // Executa a requisição para a API
    private func executeRequest(urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, _, error in

            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }

            completion(.success(data))

        })
        dataTask.resume()
    }
}

extension API: TokenServiceProtocol {
    // função responsável por gerar um token de acesso na API
    func generateToken(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = Url.urlGenerateAcessToken
        let parameters = "client_id=WfGVetIoPk0AtwIvrRL5Aok1FYThwOmd&client_secret=kGJpPg4z6WMFmAAo&grant_type=client_credentials"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        executeRequest(urlRequest: request, completion: completion)
    }

    // função responsável por atualizar informações de token
    func getTokenInformation(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = Url.urlGetTokenInformation
        let request = URLRequest(url: url)
        executeRequest(urlRequest: request, completion: completion)
    }
}
