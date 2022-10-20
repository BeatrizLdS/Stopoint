//
//  OfferView.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 20/10/22.
//

import UIKit

class OfferView: UIView {

    var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(priceLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        let priceLabelConstraints = [
            priceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        NSLayoutConstraint.activate(priceLabelConstraints)
    }
}
