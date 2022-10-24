//
//  RoutesView.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 24/10/22.
//

import UIKit

class RoutesView: UIView {

    lazy var avaliableRoutesTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .systemBackground
        // registra célula
        table.register(RouteTableViewCell.self, forCellReuseIdentifier: RouteTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        addSubview(avaliableRoutesTable)
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
        NSLayoutConstraint.activate(avaliableRoutesTableConstraints)
    }

}
