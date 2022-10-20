//
//  OfferTableViewCell.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 20/10/22.
//

import UIKit

class OfferTableViewCell: UITableViewCell {

    static let identifier = "cell"

    var offerComponent: OfferView = {
        var view = OfferView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .systemFill
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

    private func setConstraints() {
        let offerComponentConstraints = [
            offerComponent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            offerComponent.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            offerComponent.heightAnchor.constraint(equalToConstant: 50),
            offerComponent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            offerComponent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(offerComponentConstraints)
    }

}
