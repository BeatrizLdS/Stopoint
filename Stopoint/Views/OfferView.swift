//
//  OfferView.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 20/10/22.
//

import UIKit

class OfferView: UIView {

    var pricesStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.backgroundColor = .clear
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .systemCyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(pricesStackView)
        self.addSubview(lineView)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemFill.cgColor
        self.layer.cornerRadius = 10
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func inserctTravelers(travellerPrincingList: [TravelerPricings]) {
        travellerPrincingList.forEach { travaller in
            let idLabel = UILabel()
            idLabel.text = travaller.travelerId
            idLabel.textAlignment = .center
            let travellertypeLabel = UILabel()
            travellertypeLabel.text = travaller.travelerType.capitalizeFirstLetter()
            travellertypeLabel.textAlignment = .center
            let priceLabel = UILabel()
            priceLabel.text = "R$ \(travaller.price.total)"
            priceLabel.textAlignment = .center
            priceLabel.font = UIFont.boldSystemFont(ofSize: 16.0)

            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fillEqually
            horizontalStack.alignment = .center
            horizontalStack.addArrangedSubview(idLabel)
            horizontalStack.addArrangedSubview(travellertypeLabel)
            horizontalStack.addArrangedSubview(priceLabel)
            horizontalStack.translatesAutoresizingMaskIntoConstraints = false

            pricesStackView.addArrangedSubview(horizontalStack)
        }
    }

    private func setConstraints() {
        let pricesStackViewConstraints = [
            pricesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pricesStackView.topAnchor.constraint(equalTo: self.topAnchor),
            pricesStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            pricesStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            pricesStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ]
        let lineViewConstraints = [
            lineView.leadingAnchor.constraint(equalTo: pricesStackView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: pricesStackView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: pricesStackView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ]
        NSLayoutConstraint.activate(pricesStackViewConstraints)
        NSLayoutConstraint.activate(lineViewConstraints)
    }
}
