//
//  ViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: ViewModel?

    var getRoutesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("get Routes", for: .normal)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = ViewModel(account: Account(clientId: "", token: "", expireTokenTime: 0))
        viewModel!.generateAccessToken()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(getRoutesButton)
        setConstraints()

        getRoutesButton.addTarget(self, action: #selector(self.getAirportRoutes), for: .touchUpInside)
    }

    func setConstraints() {
        let getRoutesButtonConstraints = [
            getRoutesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getRoutesButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(getRoutesButtonConstraints)
    }

    @objc func getAirportRoutes() {
        viewModel!.getAirportRoutes()
    }
}
