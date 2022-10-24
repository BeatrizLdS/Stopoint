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
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .systemBackground
        // registra célula
        table.register(RouteTableViewCell.self, forCellReuseIdentifier: RouteTableViewCell.identifier)
        return table
    }()

    var getRoutesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("get flights", for: .normal)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Função chamada na primeira vez que a view vai ser criada
    override func loadView() {
        super.loadView()
        viewModel = RoutesViewModel(routes: Routes())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rotas"
        view.backgroundColor = .systemBackground
        view.addSubview(avaliableRoutesTable)
        avaliableRoutesTable.delegate = self
        avaliableRoutesTable.dataSource = self
        viewModel?.delegate = self
        viewModel!.getAirportRoutes()
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
            let formVM = FormViewModel(location: location)
            let nextController = FormViewController()
            nextController.viewModel = formVM
            self.navigationController?.pushViewController(nextController, animated: true)
        })
    }
}

extension RoutesViewController: UITableViewDelegate {

}

extension RoutesViewController: DataDelegate {
    func updateDatas() {
        Task {
            self.avaliableRoutesTable.reloadData()
        }
    }
}
