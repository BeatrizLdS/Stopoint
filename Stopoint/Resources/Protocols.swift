//
//  Protocols.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 20/10/22.
//

import Foundation


protocol RoutesDelegate: AnyObject {
    func updateRoute(destiny: String)
}

protocol DataDelegate: AnyObject {
    func errorProduced(error: CustomError)
    func updateDatas()
}
