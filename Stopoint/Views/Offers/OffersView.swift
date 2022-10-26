//
//  OffersView.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 26/10/22.
//

import UIKit

class OffersView: UIView {

    var flightOffersTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .systemBackground
        // registra célula
        table.register(OfferTableViewCell.self, forCellReuseIdentifier: OfferTableViewCell.identifier)
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addSubview(flightOffersTableView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        flightOffersTableView.frame = self.bounds
    }
}
