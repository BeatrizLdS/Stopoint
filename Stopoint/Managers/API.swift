//
//  API.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import Foundation

// Requisições relacionadas com as rotas (origem -> destino) / Origem = Fortaleza
class API {

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

    func getTokenInformation(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = Url.urlGetTokenInformation
        let request = URLRequest(url: url)
        executeRequest(urlRequest: request, completion: completion)
    }

    func getRoutes(completion: @escaping (Result<Data, Error>) -> Void) {
        let token = KeychainHelper.standard.read(service: "access-token", account: "amadeus")!
        let accessToken = String(data: token, encoding: .utf8)!
        let url = Url.urlAirportRoutes
        var request = URLRequest(url: url)
        request.addValue("Baerer \(accessToken)", forHTTPHeaderField: "Authorization")
        executeRequest(urlRequest: request, completion: completion)
    }

    func executeRequest(urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
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
