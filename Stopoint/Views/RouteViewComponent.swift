//
//  RouteViewComponent.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 19/10/22.
//

import UIKit

class RouteViewComponent: UIView {

    var originLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var destinyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var airplaneImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "airplane"))
        image.tintColor = .systemCyan
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    var containerStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        stack.layer.cornerRadius = 10
        stack.distribution = .fillEqually
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.systemCyan.cgColor
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(containerStackView)
        self.containerStackView.addArrangedSubview(originLabel)
        self.containerStackView.addArrangedSubview(airplaneImage)
        self.containerStackView.addArrangedSubview(destinyLabel)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        let containerStackConstraints = [
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        let airplaneImageConstraints = [
            airplaneImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        NSLayoutConstraint.activate(airplaneImageConstraints)
        NSLayoutConstraint.activate(containerStackConstraints)
    }
}
