//
//  UserConfigurationController.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import UIKit

protocol UserConfigurationControllerDelegate: AnyObject {
    func didTapAddPhotoButton()
    func didTapCloseButton()
}

class UserConfigurationController: UIViewController {
    private let viewModel: UserConfigurationViewModel
    private weak var delegate: UserConfigurationControllerDelegate?

    init(
        viewModel: UserConfigurationViewModel,
        delegate: UserConfigurationControllerDelegate
    ) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
}

extension UserConfigurationController {
    private func setupUI() {
        let closeButton = UIBarButtonItem(
            systemItem: .close,
            primaryAction: closeActions()
        )
        navigationItem.leftBarButtonItem = closeButton

        var config = UIButton.Configuration.filled()
        config.title = "Add Photo"
        config.image = UIImage(
            systemName: "photo",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
        config.imagePlacement = .leading
        config.imagePadding = 8.0
        config.cornerStyle = .capsule
        config.titleAlignment = .center
        config.buttonSize = .large
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 20,
            bottom: 10,
            trailing: 20
        )
        let photoButton = UIButton()
        photoButton.configuration = config
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoButton)
        photoButton.addAction(addActions(), for: .touchUpInside)

        NSLayoutConstraint.activate([
            photoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension UserConfigurationController {
    private func addActions() -> UIAction {
        UIAction { [weak self] _ in
            self?.delegate?.didTapAddPhotoButton()
        }
    }

    private func closeActions() -> UIAction {
        UIAction { [weak self] _ in
            self?.delegate?.didTapCloseButton()
        }
    }
}
