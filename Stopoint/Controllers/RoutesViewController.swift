//
//  ViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import UIKit

class RoutesViewController: UIViewController {
    var viewModel: RoutesViewModel?
    var routesView = RoutesView()

    // Função chamada na primeira vez que a view vai ser criada
    override func loadView() {
        super.loadView()
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

// Protocolo responsável por determinar as células e seus dados
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
        cell.routeComponent.originLabel.text = "Fortaleza"
        cell.routeComponent.destinyLabel.text = viewModel?.loadCurrentRoute(indexPath: indexPath).name?.capitalizeFirstLetter()
        return cell
    }

    // Função que define a ação da seleção de uma linha
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            let location = (self.viewModel?.loadCurrentRoute(indexPath: indexPath))
            let nextController = FormViewController(location: location!)
            self.navigationController?.pushViewController(nextController, animated: true)
        })
    }
}

extension RoutesViewController: UITableViewDelegate {

}

extension RoutesViewController: DataDelegate {
    func updateDatas() {
        Task {
            self.routesView.avaliableRoutesTable.reloadData()
        }
    }
}
