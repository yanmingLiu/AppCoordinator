//
//  SettingsCell.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

class SettingsCell: UICollectionViewCell {
    private var viewModel: SettingsItemViewModel!

    private let icon = UIImageView()
    private let accessoryImageView = UIImageView()
    private let textLabel = UILabel()
    private let seperatorView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fill(with viewModel: SettingsItemViewModel) {
        self.viewModel = viewModel
        icon.image = UIImage(systemName: viewModel.icon)
        textLabel.text = viewModel.title
    }

    private func setupUI() {
        contentView.addSubview(icon)
        contentView.addSubview(textLabel)
        contentView.addSubview(accessoryImageView)
        contentView.addSubview(seperatorView)

        contentView.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        seperatorView.backgroundColor = .separator

        textLabel.font = .preferredFont(forTextStyle: .body)

        let chevronImage = UIImage(systemName: "chevron.right")
        accessoryImageView.image = chevronImage
        accessoryImageView.tintColor = UIColor.lightGray.withAlphaComponent(0.7)

        let padding: CGFloat = 16
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 30),
            icon.heightAnchor.constraint(equalToConstant: 30),
            icon.leadingAnchor.constraint(equalTo: contentView
                .leadingAnchor, constant: padding),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: padding),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            seperatorView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 1),
            seperatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 13),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

        ])
    }
}
