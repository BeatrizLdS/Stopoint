//
//  FormViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 19/10/22.
//

import UIKit

class FormViewController: UIViewController {

    var alertService = AlertService()
    var viewModel: FormViewModel?
    var formView: FormView?

    init(location: Location) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = FormViewModel(location: location)
        self.formView = FormView()
        self.alertService.alertActionDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = formView
        title = "Configuração"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pesquisar",
                                                            style: .done, target: self,
                                                            action: #selector(searchFlights))
        view.backgroundColor = .systemBackground

        viewModel?.delegate = self
        fetchData()
        configKeyBoardTapGesture()
    }

    func configKeyBoardTapGesture() {
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(gesture)
    }

    @objc func searchFlights() {
        view.endEditing(true)
        if formView?.childrensNumberTextField.text == "" && formView?.adultsNumberTextField.text == "" {
            let warning = Warning(title: "Nenhuma passageiro!",
                                  message: "Adicione pelo menos uma pessoa para buscar a viagem!")
            alertService.warning = warning
            self.present(alertService.generateAlert(), animated: true)
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nowDate = dateFormatter.string(from: Date.now)
        let datePickerFormatted = dateFormatter.string(from: (formView?.datePickerView.date)!)
        if nowDate != datePickerFormatted && (formView?.datePickerView.date)! < Date.now {
            let warning = Warning(title: "Data inválida!",
                                  message: "Insira uma data no presente ou no futuro!")
            alertService.warning = warning
            self.present(alertService.generateAlert(), animated: true)
            return
        }
        let settedFlight: Flight = Flight(route: ["FOR", viewModel?.location?.iataCode],
                                          departureDate: datePickerFormatted,
                                          adults: (formView?.adultsNumberTextField.text!)!,
                                          childrens: (formView?.childrensNumberTextField.text!)!)
        let nextController = FlightOffersViewController(flight: settedFlight)
        navigationController?.pushViewController(nextController, animated: true)
    }

    // Função que atualiza os dados da ViewModel
    private func fetchData() {
        viewModel!.fetchData()
    }
}

// MARK: Implementação do protocolo que gera as rotas
extension FormViewController: RoutesDelegate {
    // Função que recebe os dados vindos da viewModel
    func updateRoute(destiny: String) {
        formView?.routeView.originLabel.text = "Fortaleza"
        formView?.routeView.destinyLabel.text = destiny.capitalizeFirstLetter()
    }
}

// MARK: Implementação do protocolo que gera os alertar
extension FormViewController: AlertDelegate {
    func alertAction() {
    }
}
