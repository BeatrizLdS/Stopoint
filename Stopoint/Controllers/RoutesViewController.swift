//
//  ViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import UIKit

class RoutesViewController: UIViewController {
    var viewModel: RoutesViewModel?

    var getRoutesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("get flights", for: .normal)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = RoutesViewModel(account: Account(clientId: "", token: "", expireTokenTime: 0))
        viewModel!.getAirportRoutes()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(getRoutesButton)
        setConstraints()

        getRoutesButton.addTarget(self, action: #selector(self.nextPage), for: .touchUpInside)
    }

    func setConstraints() {
        let getRoutesButtonConstraints = [
            getRoutesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getRoutesButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(getRoutesButtonConstraints)
    }

    @objc func nextPage() {
        viewModel?.verifyToken()
        let nextViewController =  FlightOffersViewController()
        let flight = Flight(originLocation: "FOR", destinationLocation: (viewModel?.routes?.routes?[0].iataCode)!, departureDate: "2022-11-01", adults: 2)
        nextViewController.viewModel.flight = flight
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
