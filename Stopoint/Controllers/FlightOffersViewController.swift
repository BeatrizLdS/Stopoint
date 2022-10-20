//
//  FlightViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 17/10/22.
//

import UIKit

class FlightOffersViewController: UIViewController {

    var viewModel: FlightOffersViewModel?

    var getDetailCodesButton: UIButton = {
        var button = UIButton()
        button.setTitle("Obter detalhes", for: .normal)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ofertas"
        view.backgroundColor = .systemBackground
        view.addSubview(getDetailCodesButton)
        setConstraints()

        getDetailCodesButton.addTarget(self, action: #selector(self.getDetails), for: .touchUpInside)
        print(viewModel?.flight)
        viewModel!.searchFlighOffers()
    }

    func setConstraints() {
        let getRoutesButtonConstraints = [
            getDetailCodesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getDetailCodesButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(getRoutesButtonConstraints)
    }

    @objc func getDetails() {
        viewModel!.getCityDetails()
    }
}
