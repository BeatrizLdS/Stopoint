//
//  Account.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import Foundation

struct Account: Decodable {
    var clientId: String
    var token: String
    var expireTokenTime : Int

    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case token = "access_token"
        case expireTokenTime = "expires_in"
    }
}
