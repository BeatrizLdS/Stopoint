//
//  FormViewModel.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 19/10/22.
//

import Foundation

protocol FormViewModelDelegate {
    func updateRoute(destiny: String)
}

class FormViewModel {

    var location: Location?

    var delegate: FormViewModelDelegate?

    init(location: Location? = nil) {
        self.location = location
    }

    public func fetchData() {
        delegate?.updateRoute(destiny: (location?.name)!)
    }
}
