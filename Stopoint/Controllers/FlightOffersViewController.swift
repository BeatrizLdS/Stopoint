//
//  FlightViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 17/10/22.
//

import UIKit

class FlightOffersViewController: UIViewController {

    var viewModel: FlightOffersViewModel = FlightOffersViewModel()

    override func viewWillAppear(_ animated: Bool) {
        viewModel.searchFlighOffers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
