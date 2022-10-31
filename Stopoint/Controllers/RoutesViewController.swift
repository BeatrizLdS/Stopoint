//
//  ViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import UIKit

class RoutesViewController: UIViewController {

    var alertService = AlertService()
    var viewModel: RoutesViewModel?
    var routesView = RoutesView()

    // Função chamada na primeira vez que a view vai ser criada
    override func loadView() {
        super.loadView()
        alertService.alertActionDelegate = self
        viewModel = RoutesViewModel(routes: Routes())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rotas"
        view = routesView

        routesView.avaliableRoutesTable.delegate = self
        routesView.avaliableRoutesTable.dataSource = self
        viewModel?.delegate = self

        viewModel!.getAirportRoutes()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: Protocólo responsável por determinar as células e seus dados
extension RoutesViewController: UITableViewDataSource {

    // Número de linhas em cada seção
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel!.numberOfRows ?? 0
    }

    // Define a altura
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    // Define os dados de cada célula e que. é a célula
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RouteTableViewCell.identifier, for: indexPath) as? RouteTableViewCell else {
            return UITableViewCell()
        }
        let currentRoute = viewModel?.loadCurrentRoute(indexPath: indexPath)
        cell.configure(location: currentRoute!)
        return cell
    }

    // Função que define a ação da seleção de uma linha
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let haptics = UISelectionFeedbackGenerator()
        haptics.selectionChanged()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            let location = (self.viewModel?.loadCurrentRoute(indexPath: indexPath))
            let nextController = FormViewController(location: location!)
            self.navigationController?.pushViewController(nextController, animated: true)
        })
    }
}

extension RoutesViewController: UITableViewDelegate {

}

// MARK: Implementação do protocolo que gera e verifica as ofertas
extension RoutesViewController: DataDelegate {
    func errorProduced(error: CustomErrors) {
        switch error {
        case .offersNotFound:
            let warning = Warning(title: "Nenhuma oferta encontrada!",
                                  message: error.localizedDescription)
            alertService.warning = warning
            Task {
                self.present(alertService.generateAlert(), animated: true)
            }
        case .invalidRequest:
            let warning = Warning(title: "Falha de conexão!",
                                  message: error.localizedDescription)
            alertService.warning = warning
            Task {
                self.present(alertService.generateAlert(), animated: true)
            }
        case .invalidResponse:
            let warning = Warning(title: "Problemas com o servidor!",
                                  message: error.localizedDescription)
            alertService.warning = warning
            Task {
                self.present(alertService.generateAlert(), animated: true)
            }
        }
    }

    func updateDatas() {
        Task {
            self.routesView.avaliableRoutesTable.reloadData()
            self.routesView.progressView.stopAnimating()
            self.routesView.progressView.isHidden = true
            self.routesView.avaliableRoutesTable.isHidden = false
        }
    }
}

// MARK: Implementação do protocolo que gera os alertar
extension RoutesViewController: AlertDelegate {
    func alertAction() {
        self.viewModel?.getAirportRoutes()
    }
}
