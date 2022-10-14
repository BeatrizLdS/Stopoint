//
//  Keychain.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 14/10/22.
//

import Foundation

final class KeychainHelper {

    static let standard = KeychainHelper()
    private init() {}

    func save(data: Data, service: String, account: String) {

        // Criação query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        // Adicionando dado do query para o keychain
        let status = SecItemAdd(query, nil)

        if status != errSecSuccess {
            print("Error: \(status)")
        }

        if status == errSecDuplicateItem {
            // setar dados que já existem
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword
            ]as CFDictionary

            // seta atributo que vai ser alterado
            let attributesToUpdate = [
                kSecValueData: data
            ] as CFDictionary

            // atualiza o item
            SecItemUpdate(query, attributesToUpdate)

            print("Os dados do keychain foram atualizados")
        }
    }

    func read(service: String, account: String) -> Data? {

        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ]as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)

        return (result as? Data)
    }

    func delete(service: String, account: String) {

        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ]as CFDictionary

        // Deletar item do keychain
        SecItemDelete(query)
    }

}
