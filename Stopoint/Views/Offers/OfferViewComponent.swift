//
//  OfferView.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 20/10/22.
//

import UIKit

class OfferViewComponent: UIView {

    var routeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .systemFill
        stack.layer.cornerRadius = 8
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.systemFill.cgColor
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    var valuesLabel: UILabel = {
        let label =  UILabel()
        label.text = "Valores: "
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var pricesStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.backgroundColor = .clear
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    var topLineView: UIView = {
        var view = UIView()
        view.backgroundColor = .systemFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var bottomLineView: UIView = {
        var view = UIView()
        view.backgroundColor = .systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var totalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(routeStackView)
        self.addSubview(valuesLabel)
        self.addSubview(topLineView)
        self.addSubview(pricesStackView)
        self.addSubview(bottomLineView)
        self.addSubview(totalStackView)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.cornerRadius = 10
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func inserctTravelers(travellerPrincingList: [TravelerPricings]) {
        travellerPrincingList.forEach { travaller in
            let travellertypeLabel = UILabel()
            travellertypeLabel.text = travaller.travelerType.capitalizeFirstLetter()
            travellertypeLabel.textAlignment = .center

            let emptySpace = UILabel()
            emptySpace.text = " "
            emptySpace.translatesAutoresizingMaskIntoConstraints = false

            let priceLabel = UILabel()
            priceLabel.text = "R$ \(travaller.price.total)"
            priceLabel.textAlignment = .center
            priceLabel.font = UIFont.boldSystemFont(ofSize: 16.0)

            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fillEqually
            horizontalStack.alignment = .center
            horizontalStack.addArrangedSubview(travellertypeLabel)
            horizontalStack.addArrangedSubview(emptySpace)
            horizontalStack.addArrangedSubview(priceLabel)
            horizontalStack.translatesAutoresizingMaskIntoConstraints = false

            pricesStackView.addArrangedSubview(horizontalStack)
        }
    }

    public func generateTotalView(price: Price) {
        let totalLabel = UILabel()
        totalLabel.text = "Total"
        totalLabel.textAlignment = .center
        totalLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        let emptySpace = UILabel()
        emptySpace.text = " "
        emptySpace.translatesAutoresizingMaskIntoConstraints = false
        let valueLabel = UILabel()
        valueLabel.text = "R$\(price.total)"
        valueLabel.textAlignment = .center
        valueLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        totalStackView.addArrangedSubview(totalLabel)
        totalStackView.addArrangedSubview(emptySpace)
        totalStackView.addArrangedSubview(valueLabel)
    }

    public func generateRouteStackView(itineraries: Itinerarie, locations: [Location]) {
        itineraries.segments?.forEach { segment in
            let routeView = RouteViewComponent()
            if let city = locations.first(where: {$0.iataCode == segment.departure.location}) {
                routeView.originLabel.text = city.name?.capitalizeFirstLetter()
            } else {
                routeView.originLabel.text = segment.departure.location
            }
            if let city = locations.first(where: {$0.iataCode == segment.arrival.location}) {
                routeView.destinyLabel.text = city.name?.capitalizeFirstLetter()
            } else {
                routeView.destinyLabel.text = segment.arrival.location
            }
            routeView.originLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            routeView.destinyLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            routeView.translatesAutoresizingMaskIntoConstraints = false

            routeStackView.addArrangedSubview(routeView)
        }
    }

    private func setConstraints() {
        let routeStackViewConstraints = [
            routeStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            routeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            routeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ]
        let valuesLabelConstraints = [
            valuesLabel.topAnchor.constraint(equalTo: routeStackView.bottomAnchor, constant: 10),
            valuesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ]
        let topLineViewConstraints = [
            topLineView.leadingAnchor.constraint(equalTo: valuesLabel.leadingAnchor),
            topLineView.trailingAnchor.constraint(equalTo: pricesStackView.trailingAnchor),
            topLineView.topAnchor.constraint(equalTo: valuesLabel.bottomAnchor, constant: 2),
            topLineView.heightAnchor.constraint(equalToConstant: 2)
        ]
        let pricesStackViewConstraints = [
            pricesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pricesStackView.topAnchor.constraint(equalTo: topLineView.bottomAnchor, constant: 5),
            pricesStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            pricesStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ]
        let bottomLineViewConstraints = [
            bottomLineView.leadingAnchor.constraint(equalTo: pricesStackView.leadingAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: pricesStackView.trailingAnchor),
            bottomLineView.topAnchor.constraint(equalTo: pricesStackView.bottomAnchor, constant: 2),
            bottomLineView.heightAnchor.constraint(equalToConstant: 2)
        ]
        let totalStackViewConstraints = [
            totalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            totalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            totalStackView.topAnchor.constraint(equalTo: bottomLineView.bottomAnchor, constant: 2)
        ]
        NSLayoutConstraint.activate(routeStackViewConstraints)
        NSLayoutConstraint.activate(valuesLabelConstraints)
        NSLayoutConstraint.activate(topLineViewConstraints)
        NSLayoutConstraint.activate(pricesStackViewConstraints)
        NSLayoutConstraint.activate(bottomLineViewConstraints)
        NSLayoutConstraint.activate(totalStackViewConstraints)
    }
}
