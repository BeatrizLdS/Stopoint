//
//  Account.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import Foundation

struct Authorization: Decodable{
    var clientId: String
    var token: String

    enum CodingKeys: String, CodingKey{
        case clientId = "client_id"
        case token = "access_token"
    }
}
