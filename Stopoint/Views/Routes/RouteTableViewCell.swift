//
//  RouteCellView.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 18/10/22.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    static let identifier = "cell"

    var routeComponent: RouteViewComponent = {
        let routeView = RouteViewComponent()
        routeView.layer.cornerRadius = 10
        routeView.layer.borderWidth = 1
        routeView.layer.borderColor = UIColor.systemCyan.cgColor
        routeView.translatesAutoresizingMaskIntoConstraints = false
        return routeView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // Função que adiciona efeito nos estados isSelect
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.isSelected {
            selectedBackgroundView?.backgroundColor = .clear
            // Todas essas animações rodam em paralelo
            UIView.animate(withDuration: 0.5) {
                self.routeComponent.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
                self.routeComponent.transform = .identity
            }
            UIView.animate(withDuration: 0.5) {
                self.routeComponent.layer.borderWidth = 4
                self.routeComponent.layer.borderWidth = 1
            }
            UIView.animate(withDuration: 0.5) {
                self.routeComponent.airplaneImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.routeComponent.airplaneImage.transform = .identity
            }
            isSelected = false
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(routeComponent)
        setConstraints()
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    public func configure(location: Location) {
        self.routeComponent.originLabel.text = "Fortaleza"
        self.routeComponent.destinyLabel.text = location.name?.capitalizeFirstLetter()
    }

    private func setConstraints() {
        let containerStackViewConstraints = [
            routeComponent.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            routeComponent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            routeComponent.heightAnchor.constraint(equalToConstant: 50),
            routeComponent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            routeComponent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(containerStackViewConstraints)
    }
}
