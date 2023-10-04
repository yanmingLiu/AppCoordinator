//
//  PostDetailViewController.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import UIKit

protocol PostDetailViewControllerDelegate: AnyObject {
    func didTapPhotoButton()
}

class PostDetailViewController: UIViewController {
    private let delegate: PostDetailViewControllerDelegate?

    private var photoButton = UIButton()

    init(delegate: PostDetailViewControllerDelegate?) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
}

extension PostDetailViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground

        var config = UIButton.Configuration.filled()
        config.title = "Add Photo"
        config.image = UIImage(systemName: "photo",
                               withConfiguration: UIImage.SymbolConfiguration(scale: .large))
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
        photoButton.configuration = config
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoButton)

        NSLayoutConstraint.activate([
            photoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension PostDetailViewController {
    private func setupActions() {
        let addPhotoAction = UIAction { [weak self] _ in
            self?.delegate?.didTapPhotoButton()
        }
        photoButton.addAction(addPhotoAction, for: .touchUpInside)
    }
}
