//
//  ViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import UIKit

class RoutesViewController: UIViewController {
    var viewModel: RoutesViewModel?

    var avaliableRoutesTable: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .systemBackground
        table.register(RouteTableViewCell.self, forCellReuseIdentifier: RouteTableViewCell.identifier) // registra célula
        return table
    }()

    var getRoutesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("get flights", for: .normal)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = RoutesViewModel()
        viewModel!.getAirportRoutes()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Rotas"
        view.backgroundColor = .systemBackground
        view.addSubview(avaliableRoutesTable)
        avaliableRoutesTable.delegate = self
        avaliableRoutesTable.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avaliableRoutesTable.frame = view.bounds
    }

    func setConstraints() {
        let getRoutesButtonConstraints = [
            getRoutesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getRoutesButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(getRoutesButtonConstraints)
    }

    @objc func nextPage() {
        Token.verifyToken()
//        let nextViewController =  FlightOffersViewController()
//        let flight = Flight(originLocation: "FOR",
//                            destinationLocation: (viewModel?.routes?.routes?[0].iataCode)!,
//                            departureDate: "2022-11-01",
//                            adults: 2)
//        nextViewController.viewModel.flight = flight
//        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// Protocolo responsável por determinar as células e seus dados
extension RoutesViewController: UITableViewDataSource {

    // Número de linhas em cada seção
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel!.numberOfRows ?? 1
    }

    // Define os dados de cada célula e que. é a célula
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RouteTableViewCell.identifier, for: indexPath) as? RouteTableViewCell else {
            return UITableViewCell()
        }
        cell.originLabel.text = "origin"
        cell.destinyLabel.text = "destiny"
        return cell
    }
}

extension RoutesViewController: UITableViewDelegate {

}
