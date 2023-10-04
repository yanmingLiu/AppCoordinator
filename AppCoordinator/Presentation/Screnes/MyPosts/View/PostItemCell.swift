//
//  PostItemCell.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import UIKit

class PostItemCell: UICollectionViewCell {
    private var viewModel: PostItemViewModel!

    private let container = UIView()
    private let icon = UIImageView()
    private let avatar = UIImageView()
    private let textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fill(with viewModel: PostItemViewModel) {
        self.viewModel = viewModel
        icon.image = UIImage(named: viewModel.icon)
        textLabel.text = viewModel.title
        avatar.image = UIImage(systemName: viewModel.authorAvatar)
    }

    private func setupUI() {
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)

        icon.contentMode = .scaleAspectFill
        icon.layer.masksToBounds = true

        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 10

        container.addSubview(icon)
        container.addSubview(avatar)
        container.addSubview(textLabel)

        container.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        textLabel.font = .preferredFont(forTextStyle: .body)

        let padding: CGFloat = 16
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            icon.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            icon.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            icon.heightAnchor.constraint(equalToConstant: 200),

            avatar.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            avatar.heightAnchor.constraint(equalToConstant: 20),
            avatar.widthAnchor.constraint(equalToConstant: 20),
            avatar.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: padding),

            textLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: padding),
            textLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            textLabel.trailingAnchor.constraint(equalTo: avatar.leadingAnchor, constant: -padding),
            textLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding),
        ])

        shadowDecorate()
    }

    func shadowDecorate() {
        let radius: CGFloat = 16
        contentView.layer.cornerRadius = radius
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
