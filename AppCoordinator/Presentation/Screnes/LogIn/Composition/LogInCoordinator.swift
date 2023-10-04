//
//  LogInCoordinator.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

protocol LogInCoordinatorDelegate: AnyObject {
    func didFinishLogin()
}

final class LogInCoordinator: Coordinator {
    var navigation: Navigation

    var factory: LogInFactory

    weak var delegate: LogInCoordinatorDelegate?

    init(navigation: Navigation, factory: LogInFactory, delegate: LogInCoordinatorDelegate?) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }

    func start() {
        let controller = factory.makeLogInViewController(delegate: self)
        navigation.rootViewController.pushViewController(controller, animated: false)
    }
}

extension LogInCoordinator: LogInViewContollerDelegate {
    func didFinishLogIn() {
        delegate?.didFinishLogin()
    }
}
