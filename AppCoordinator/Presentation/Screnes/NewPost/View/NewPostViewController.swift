//
//  NewPostViewController.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import UIKit

protocol NewPostViewControllerDelegate: AnyObject {
    func didSaveNewPost(title: String)
}

class NewPostViewController: UIViewController {
    private var viewModel: NewPostViewModel
    private weak var delegate: NewPostViewControllerDelegate?

    private let saveButton: UIButton = .init()

    init(viewModel: NewPostViewModel, delegate: NewPostViewControllerDelegate?) {
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
        bind(to: viewModel)
        setupActions()
    }
}

// MARK: - UI

extension NewPostViewController {
    private func setupUI() {
        var config = UIButton.Configuration.filled()
        config.title = "Save Post"
        config.cornerStyle = .capsule
        config.titleAlignment = .center
        config.buttonSize = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                       leading: 20, bottom: 10, trailing: 20)
        saveButton.configuration = config
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - ViewModel

extension NewPostViewController {
    private func bind(to _: NewPostViewModel) {}
}

// MARK: - Actions

extension NewPostViewController {
    private func setupActions() {
        let saveAction = UIAction { [weak self] _ in
            self?.delegate?.didSaveNewPost(title: "Post Title #\(Int.random(in: 0 ... 999))")
        }
        saveButton.addAction(saveAction, for: .touchUpInside)
    }
}
