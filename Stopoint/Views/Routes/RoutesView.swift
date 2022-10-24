//
//  RoutesView.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 24/10/22.
//

import UIKit

class RoutesView: UIView {

    lazy var progressView: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView(style: .medium)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.startAnimating()
        progressView.isHidden = false

        return progressView
    }()

    lazy var avaliableRoutesTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .systemBackground
        // registra célula
        table.register(RouteTableViewCell.self, forCellReuseIdentifier: RouteTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        addSubview(avaliableRoutesTable)
        addSubview(progressView)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        let avaliableRoutesTableConstraints = [
            avaliableRoutesTable.topAnchor.constraint(equalTo: self.topAnchor),
            avaliableRoutesTable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            avaliableRoutesTable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            avaliableRoutesTable.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        let progressViewConstraints = [
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        NSLayoutConstraint.activate(avaliableRoutesTableConstraints)
        NSLayoutConstraint.activate(progressViewConstraints)
    }

}
