//
//  OffersView.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 26/10/22.
//

import UIKit

class FlightsOffersView: UIView {

    lazy var progressView: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView(style: .medium)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.startAnimating()
        progressView.isHidden = false

        return progressView
    }()

    var flightOffersTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        // registra célula
        table.register(OfferTableViewCell.self, forCellReuseIdentifier: OfferTableViewCell.identifier)
        table.isHidden = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addSubview(flightOffersTableView)
        addSubview(progressView)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        let flightOffersTableViewConstraints = [
            flightOffersTableView.topAnchor.constraint(equalTo: self.topAnchor),
            flightOffersTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            flightOffersTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            flightOffersTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        let progressViewConstraints = [
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        NSLayoutConstraint.activate(progressViewConstraints)
        NSLayoutConstraint.activate(flightOffersTableViewConstraints)
    }
}
