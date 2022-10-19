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
        image.contentMode = .center
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var containerStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        stack.layer.cornerRadius = 10
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.systemCyan.cgColor
        return stack
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(containerStackView)
        self.containerStackView.addArrangedSubview(originLabel)
        self.containerStackView.addArrangedSubview(airplaneImage)
        self.containerStackView.addArrangedSubview(destinyLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }

    private func setConstraints() {
        let containerStackViewConstraints = [
            containerStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            containerStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            containerStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(containerStackViewConstraints)
    }

}
