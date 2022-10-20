//
//  FormViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 19/10/22.
//

import UIKit

class FormViewController: UIViewController {

    var viewModel: FormViewModel?

    var routeView: RouteViewComponent = {
        var routeView = RouteViewComponent()
        routeView.containerStackView.layer.borderColor = UIColor.systemGray.cgColor
        routeView.translatesAutoresizingMaskIntoConstraints = false
        return routeView
    }()

    var selectDateLabel: UILabel = {
        var label = UILabel()
        label.text = "Dia da viagem:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    var childrensNumberLabel: UILabel = {
        var label = UILabel()
        label.text = "Numero de crianças:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var childrensNumberTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Número de crianças"
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemFill.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    var adultsNumberLabel: UILabel = {
        var label = UILabel()
        label.text = "Numero de adultos:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var adultsNumberTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Número de adultos"
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemFill.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Configurar Viagem"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pesquisar",
                                                            style: .done, target: self,
                                                            action: #selector(searchFlights))
        view.backgroundColor = .systemBackground
        view.addSubview(routeView)
        view.addSubview(adultsNumberLabel)
        view.addSubview(adultsNumberTextField)
        view.addSubview(childrensNumberLabel)
        view.addSubview(childrensNumberTextField)
        view.addSubview(selectDateLabel)
        view.addSubview(datePickerView)

        setConstraints()
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
        if (childrensNumberTextField.text == "" && adultsNumberTextField.text == "") {
            let warning = Warning(title: "Nenhuma passageiro!",
                                  message: "Adicione pelo menos uma pessoa para buscar a viagem!")
            generatAlert(warning: warning)
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nowDate = dateFormatter.string(from: Date.now)
        let datePickerFormatted = dateFormatter.string(from: datePickerView.date)
        if (nowDate != datePickerFormatted && datePickerView.date < Date.now) {
            let warning = Warning(title: "Data inválida!",
                                  message: "Insira uma data no presente ou no futuro!")
            generatAlert(warning: warning)
            return
        }
        let settedFlight: Flight = Flight(route: ["FOR", viewModel?.location?.iataCode],
                                          departureDate: datePickerFormatted,
                                          adults: adultsNumberTextField.text!,
                                          childrens: childrensNumberTextField.text!)
        let nextViewModel = FlightOffersViewModel(flight: settedFlight)
        let nextController = FlightOffersViewController()
        nextController.viewModel = nextViewModel
        navigationController?.pushViewController(nextController, animated: true)
    }

    // Função que gera um alerta
    private func generatAlert(warning: Warning) {
        let alert = UIAlertController(title: warning.title,
                                      message: warning.message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // Função que atualiza os dados da ViewModel
    private func fetchData() {
        viewModel!.fetchData()
    }

    // Função que configura as constraints
    private func setConstraints() {
        let routeViewConstraints = [
            routeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            routeView.heightAnchor.constraint(equalToConstant: 50),
            routeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            routeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        let adultsNumberLabelConstraints = [
            adultsNumberLabel.topAnchor.constraint(equalTo: routeView.bottomAnchor, constant: 30),
            adultsNumberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ]
        let adultsNumberTextFieldConstraints = [
            adultsNumberTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            adultsNumberTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            adultsNumberTextField.heightAnchor.constraint(equalToConstant: 35),
            adultsNumberTextField.topAnchor.constraint(equalTo: adultsNumberLabel.bottomAnchor, constant: 5)
        ]
        let childrensNumberLabelConstraints = [
            childrensNumberLabel.topAnchor.constraint(equalTo: adultsNumberTextField.bottomAnchor, constant: 20),
            childrensNumberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ]
        let childrensNumberTextFieldConstraints = [
            childrensNumberTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            childrensNumberTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            childrensNumberTextField.heightAnchor.constraint(equalToConstant: 35),
            childrensNumberTextField.topAnchor.constraint(equalTo: childrensNumberLabel.bottomAnchor, constant: 5)
        ]
        let selectDateLabelConstraints = [
            selectDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            selectDateLabel.topAnchor.constraint(equalTo: childrensNumberTextField.bottomAnchor, constant: 20)
        ]
        let datePickerViewConstraints = [
            datePickerView.topAnchor.constraint(equalTo: selectDateLabel.bottomAnchor, constant: 5),
            datePickerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ]
        NSLayoutConstraint.activate(adultsNumberLabelConstraints)
        NSLayoutConstraint.activate(adultsNumberTextFieldConstraints)
        NSLayoutConstraint.activate(childrensNumberLabelConstraints)
        NSLayoutConstraint.activate(childrensNumberTextFieldConstraints)
        NSLayoutConstraint.activate(routeViewConstraints)
        NSLayoutConstraint.activate(selectDateLabelConstraints)
        NSLayoutConstraint.activate(datePickerViewConstraints)
    }
}

extension FormViewController: FormViewModelDelegate {
    // Função que recebe os dados vindos da viewModel
    func updateRoute(destiny: String) {
        routeView.originLabel.text = "Fortaleza"
        routeView.destinyLabel.text = destiny.capitalizeFirstLetter()
    }
}
