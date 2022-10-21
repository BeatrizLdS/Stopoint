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
        table.register(OfferTableViewCell.self, forCellReuseIdentifier: OfferTableViewCell.identifier)
        return table
    }()

    override func viewWillAppear(_ animated: Bool) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pacote"
        view.backgroundColor = .systemBackground
        view.addSubview(flightOffersTableView)

        flightOffersTableView.delegate = self
        flightOffersTableView.dataSource = self
        viewModel?.delegate = self
        viewModel!.generateDatas()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flightOffersTableView.frame = view.bounds
    }
}

// Protocólo responsável por determinar as células e seus dados
extension FlightOffersViewController: UITableViewDataSource {

    // Função que define a altura de cada linha
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (viewModel?.getRowHeight(indexPath: indexPath))!
    }

    // Função que define o número de linhas de cada seção da table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.numberOfRows ?? 0
    }

    // Função que define cada célula da API e seu conteúdo
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OfferTableViewCell.identifier, for: indexPath) as? OfferTableViewCell else {
            return UITableViewCell()
        }
        let currentPackage = viewModel?.loadCurrentRoute(indexPath: indexPath)
        cell.offerComponent.inserctTravelers(travellerPrincingList: currentPackage!.travelerPricings)
        cell.offerComponent.generateTotalView(price: currentPackage!.price)
        cell.offerComponent.generateRouteStackView(itineraries: currentPackage!.itineraries[0],
                                                   locations: viewModel!.citysList)
        return cell
    }

}

extension FlightOffersViewController: UITableViewDelegate {

}

extension FlightOffersViewController: DataDelegate {
    func updateDatas() {
        Task {
            self.flightOffersTableView.reloadData()
        }
    }
}
