//
//  Errors.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 31/10/22.
//

import Foundation

enum CustomErrors: String, Error {
    case offersNotFound = "Nenhuma oferta foi encontrada com essa configuração!"
    case invalidRequest = "Verifique sua conexão e tente novamente!"
    case invalidResponse = "Informações inesperadas foram recebidas do servidor. Tente novalente!"
}

extension CustomErrors: LocalizedError {
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "")}
}
