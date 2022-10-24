//
//  FormViewModel.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 19/10/22.
//

import Foundation

class FormViewModel {

    var location: Location?

    var delegate: RoutesDelegate?

    init(location: Location? = nil) {
        self.location = location
    }

    public func fetchData() {
        delegate?.updateRoute(destiny: (location?.name)!)
    }
}
