//
//  FormVIew.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 26/10/22.
//

import UIKit

class FormView: UIView {

    var routeView: RouteViewComponent = {
        var routeView = RouteViewComponent()
        routeView.layer.cornerRadius = 10
        routeView.layer.borderWidth = 1
        routeView.layer.borderColor = UIColor.systemGray.cgColor
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(routeView)
        self.addSubview(adultsNumberLabel)
        self.addSubview(adultsNumberTextField)
        self.addSubview(childrensNumberLabel)
        self.addSubview(childrensNumberTextField)
        self.addSubview(selectDateLabel)
        self.addSubview(datePickerView)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.cornerRadius = 10
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Função que configura as constraints
    private func setConstraints() {
        let routeViewConstraints = [
            routeView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            routeView.heightAnchor.constraint(equalToConstant: 50),
            routeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            routeView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ]
        let adultsNumberLabelConstraints = [
            adultsNumberLabel.topAnchor.constraint(equalTo: routeView.bottomAnchor, constant: 30),
            adultsNumberLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ]
        let adultsNumberTextFieldConstraints = [
            adultsNumberTextField.leadingAnchor.constraint(equalTo:
                                                            self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            adultsNumberTextField.trailingAnchor.constraint(equalTo:
                                                                self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            adultsNumberTextField.heightAnchor.constraint(equalToConstant: 35),
            adultsNumberTextField.topAnchor.constraint(equalTo: adultsNumberLabel.bottomAnchor, constant: 5)
        ]
        let childrensNumberLabelConstraints = [
            childrensNumberLabel.topAnchor.constraint(equalTo: adultsNumberTextField.bottomAnchor, constant: 20),
            childrensNumberLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ]
        let childrensNumberTextFieldConstraints = [
            childrensNumberTextField.leadingAnchor.constraint(equalTo:
                                                                self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            childrensNumberTextField.trailingAnchor.constraint(equalTo:
                                                                self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            childrensNumberTextField.heightAnchor.constraint(equalToConstant: 35),
            childrensNumberTextField.topAnchor.constraint(equalTo: childrensNumberLabel.bottomAnchor, constant: 5)
        ]
        let selectDateLabelConstraints = [
            selectDateLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            selectDateLabel.topAnchor.constraint(equalTo: childrensNumberTextField.bottomAnchor, constant: 20)
        ]
        let datePickerViewConstraints = [
            datePickerView.topAnchor.constraint(equalTo: selectDateLabel.bottomAnchor, constant: 5),
            datePickerView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
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
