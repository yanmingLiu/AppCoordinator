//
//  UserConfigurationCoordinator.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import Foundation

protocol UserConfigurationCoordinatorDelegate: AnyObject {
    func didFinishFlow(_ childCoordinator: Coordinator)
}

final class UserConfigurationCoordinator: Coordinator {
    var navigation: Navigation

    private let factory: UserConfigurationFactory
    private weak var delegate: UserConfigurationCoordinatorDelegate?

    init(
        navigation: Navigation,
        factory: UserConfigurationFactory,
        delegate: UserConfigurationCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }

    func start() {
        let controller = factory.makeUserConfigurationViewController(delegate: self)
        navigation.viewControllers = [controller]
    }
}

extension UserConfigurationCoordinator: UserConfigurationControllerDelegate {
    func didTapAddPhotoButton() {
        let controller = factory.makePhotoViewController()
        navigation.push(controller, animated: true)
    }

    func didTapCloseButton() {
        delegate?.didFinishFlow(self)
    }
}
