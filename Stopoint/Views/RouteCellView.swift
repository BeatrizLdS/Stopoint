//
//  RouteCellView.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 18/10/22.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    static let identifier = "cell"

    public var originLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public var destinyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var airplaneImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "airplane"))
        image.tintColor = .systemCyan
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var containerStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        stack.layer.cornerRadius = 10
        stack.spacing = 10
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.systemCyan.cgColor
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
                self.containerStackView.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
                self.containerStackView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            UIView.animate(withDuration: 0.5) {
                self.containerStackView.layer.borderWidth = 4
                self.containerStackView.layer.borderWidth = 2
            }
            UIView.animate(withDuration: 0.5) {
                self.airplaneImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.airplaneImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
            isSelected = false
        } else {
            containerStackView.layer.borderWidth = 1
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(containerStackView)
        self.containerStackView.addArrangedSubview(originLabel)
        self.containerStackView.addArrangedSubview(airplaneImage)
        self.containerStackView.addArrangedSubview(destinyLabel)
        setConstraints()
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setConstraints() {
        let containerStackViewConstraints = [
            containerStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            containerStackView.heightAnchor.constraint(equalToConstant: 50),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        let airplaneImageConstraints = [
            airplaneImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(airplaneImageConstraints)
        NSLayoutConstraint.activate(containerStackViewConstraints)
    }
}
