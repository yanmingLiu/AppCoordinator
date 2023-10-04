//
//  AppFlowCoordinator.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

final class AppFlowCoordinator: Coordinator {
    var navigation: Navigation

    var windown: UIWindow?
    var factory: AppFactory?
    var auth: AuthCheck?

    var childCoordinators: [Coordinator] = []

    init(navigation: Navigation, windown: UIWindow?, factory: AppFactory?, auth: AuthCheck?) {
        self.navigation = navigation
        self.windown = windown
        self.factory = factory
        self.auth = auth
    }

    func start() {
        guard let auth else { return }
        auth.isSessionActive
            ? startMainTabBarCoordinator()
            : startLogInCoordinator()
    }
}

// MARK: - Private

extension AppFlowCoordinator {
    private func startLogInCoordinator() {
        let logInCoordinator = factory?.makeLogInCoordinator(navigation: navigation, delegate: self)
        addChildCoordinatorStar(logInCoordinator)
    }

    private func startMainTabBarCoordinator() {
        let tabBarCoordinator = factory?.makeMainTabBarCoordinator(navigation: navigation, delegate: self)
        addChildCoordinatorStar(tabBarCoordinator)
    }

    private func clearAllChildCoordinatorsAndStar() {
        navigation.viewControllers = []
        clearAllChildCoordinators()
        start()
    }
}

// MARK: - Delegates

extension AppFlowCoordinator: LogInCoordinatorDelegate {
    func didFinishLogin() {
        clearAllChildCoordinatorsAndStar()
    }
}

extension AppFlowCoordinator: MainTabBarCoordinatorDelegate {
    func didFinish() {
        clearAllChildCoordinatorsAndStar()
    }
}

extension AppFlowCoordinator: ParentCoordinator {}
