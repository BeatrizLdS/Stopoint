//
//  FlightViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 17/10/22.
//

import UIKit

class FlightOffersViewController: UIViewController {

    var viewModel: FlightOffersViewModel?
    var flightsOffersView: FlightsOffersView?

    init(flight: Flight) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = FlightOffersViewModel(flight: flight)
        self.flightsOffersView = FlightsOffersView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ofertas"
        view = flightsOffersView
        view.backgroundColor = .systemBackground

        flightsOffersView?.flightOffersTableView.delegate = self
        flightsOffersView?.flightOffersTableView.dataSource = self
        viewModel?.delegate = self
        viewModel!.generateDatas()
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
        cell.configure(package: currentPackage!, locations: viewModel!.citysList)
        return cell
    }

    // Função que gera um alerta
    private func generatAlert(warning: Warning) {
        let alert = UIAlertController(title: warning.title,
                                      message: warning.message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension FlightOffersViewController: UITableViewDelegate {

}

extension FlightOffersViewController: DataDelegate {
    func errorProduced(error: CustomError) {
        switch error {
        case .offersNotFound:
            let warning = Warning(title: "Nenhuma oferta encontrada!",
                                  message: "Nenhuma oferta foi encontrada com essa configuração!")
            Task {
                generatAlert(warning: warning)
            }
        }
    }

    func updateDatas() {
        Task {
            self.flightsOffersView?.flightOffersTableView.reloadData()
            self.flightsOffersView?.progressView.stopAnimating()
            self.flightsOffersView?.progressView.isHidden = true
            self.flightsOffersView?.flightOffersTableView.isHidden = false
        }
    }
}
