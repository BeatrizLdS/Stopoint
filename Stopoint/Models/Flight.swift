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
    var adults: Int
    var childrens: Int

    init(originLocation: String, destinationLocation: String, departureDate: String, adults: Int = 1, childrens: Int = 0) {
        self.originLocation = originLocation
        self.destinationLocation = destinationLocation
        self.departureDate = departureDate
        self.adults = adults
        self.childrens = childrens
    }
}
