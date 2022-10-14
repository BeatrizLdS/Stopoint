//
//  ViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: ViewModel?

    var tokenText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var getAccessTokenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("get token", for: .normal)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var getRoutesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("get Routes", for: .normal)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tokenText)
        view.addSubview(getAccessTokenButton)
        view.addSubview(getRoutesButton)
        setConstraints()

        getAccessTokenButton.addTarget(self, action: #selector(self.getTokenInformation), for: .touchUpInside)
        getRoutesButton.addTarget(self, action: #selector(self.getAirportRoutes), for: .touchUpInside)

        viewModel = ViewModel(account: Account(clientId: "", token: "", expireTokenTime: 0))
        generateToken()
        viewModel?.viewModelDelegate = self
    }

    func setConstraints() {
        let tokenTextConstraints = [
            tokenText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tokenText.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        let getAccesTokenButtonConstraints = [
            getAccessTokenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getAccessTokenButton.topAnchor.constraint(equalTo: tokenText.bottomAnchor, constant: 20)
        ]
        let getRoutesButtonConstraints = [
            getRoutesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getRoutesButton.topAnchor.constraint(equalTo: getAccessTokenButton.bottomAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(tokenTextConstraints)
        NSLayoutConstraint.activate(getAccesTokenButtonConstraints)
        NSLayoutConstraint.activate(getRoutesButtonConstraints)
    }

    // Gera um token de acesso
    func generateToken() {
        viewModel!.generateAccessToken()
    }

    // Captura o token de acesso já gerado
    @objc func getTokenInformation() {
        viewModel!.getTokenInformation()
    }
    
    @objc func getAirportRoutes() {
        viewModel!.getAirportRoutes()
    }
}

extension ViewController: ViewModelDelegate {
    func fetchAccessToken(token: String) {
        print("token de acesso obtido: \(token)")
        tokenText.text = token
    }
}
