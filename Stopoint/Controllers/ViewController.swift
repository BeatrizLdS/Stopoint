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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tokenText)
        view.addSubview(getAccessTokenButton)
        setConstraints()

        getAccessTokenButton.addTarget(self, action: #selector(self.getTokenInformation), for: .touchUpInside)

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
        NSLayoutConstraint.activate(tokenTextConstraints)
        NSLayoutConstraint.activate(getAccesTokenButtonConstraints)
    }

    // Gera um token de acesso
    func generateToken() {
        viewModel!.generateAccessToken()
    }

    // Captura o token de acesso já gerado
    @objc func getTokenInformation() {
        viewModel!.getTokenInformation()
    }
}

extension ViewController: ViewModelDelegate {
    func fetchAccessToken(token: String) {
        print("token de acesso obtido: \(token)")
        tokenText.text = token
    }
}
