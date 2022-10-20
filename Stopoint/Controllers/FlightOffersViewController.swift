//
//  FlightViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 17/10/22.
//

import UIKit

class FlightOffersViewController: UIViewController {

    var viewModel: FlightOffersViewModel?

    var flightOffersTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .systemBackground
        // registra célula
//        table.register(OfferTableViewCell.self, forCellReuseIdentifier: OfferTableViewCell.identifier)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewWillAppear(_ animated: Bool) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ofertas"
        view.backgroundColor = .systemBackground
        view.addSubview(flightOffersTableView)

        print(viewModel?.flight)
        flightOffersTableView.delegate = self
        flightOffersTableView.dataSource = self
        viewModel!.searchFlighOffers()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flightOffersTableView.frame = view.bounds
    }

    @objc func getDetails() {
        viewModel!.getCityDetails()
    }
}

// Protocólo responsável por determinar as células e seus dados
extension FlightOffersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.numberOfRows ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .blue
        return cell
    }

}

extension FlightOffersViewController: UITableViewDelegate {

}
