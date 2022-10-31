//
//  OfferTableViewCell.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 20/10/22.
//

import UIKit

class OfferTableViewCell: UITableViewCell {

    static let identifier = "cell"

    var offerComponent: OfferViewComponent = {
        var view = OfferViewComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(offerComponent)
        setConstraints()
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configure(package: TravelPackage, locations: [Location]) {
        if offerComponent.routeStackView.arrangedSubviews.isEmpty {
            offerComponent.inserctTravelers(travellerPrincingList: package.travelerPricings)
            offerComponent.generateTotalView(price: package.price)
            offerComponent.generateRouteStackView(itineraries: package.itineraries[0])
        } else {
            offerComponent.updateCitysName(itineraries: package.itineraries[0], locations: locations)
        }
    }

    private func setConstraints() {
        let offerComponentConstraints = [
            offerComponent.topAnchor.constraint(equalTo: contentView.topAnchor),
            offerComponent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            offerComponent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            offerComponent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(offerComponentConstraints)
    }

}
