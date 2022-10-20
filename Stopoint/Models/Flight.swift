//
//  Flight.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 17/10/22.
//

import Foundation

struct Flight {
    var originLocation: String
    var destinationLocation: String
    var departureDate: String
    var adults: String
    var childrens: String

    init(route: [String?], departureDate: String, adults: String, childrens: String) {
        let adultsNumber = adults == "" ? "0" : adults
        let childrensNumber = childrens == "" ? "0" : childrens
        self.originLocation = route[0]!
        self.destinationLocation = route[1]!
        self.departureDate = departureDate
        self.adults = adultsNumber
        self.childrens = childrensNumber
    }
}
