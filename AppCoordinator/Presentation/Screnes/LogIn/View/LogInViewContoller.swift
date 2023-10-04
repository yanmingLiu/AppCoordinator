//
//  LogInViewContoller.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

protocol LogInViewContollerDelegate: AnyObject {
    func didFinishLogIn()
}

class LogInViewContoller: UIViewController {
    private let viewModel: LogInViewModel
    private weak var delegate: LogInViewContollerDelegate?

    private lazy var logInButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Log In"
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(viewModel: LogInViewModel, delegate: LogInViewContollerDelegate?) {
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

        setupUI()
        setupActions()
    }
}

extension LogInViewContoller {
    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(logInButton)
        NSLayoutConstraint.activate([
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func setupActions() {
        let logInAction = UIAction { [weak self] _ in
            self?.viewModel.logIn()
            self?.delegate?.didFinishLogIn()
        }
        logInButton.addAction(logInAction, for: .touchUpInside)
    }
}
