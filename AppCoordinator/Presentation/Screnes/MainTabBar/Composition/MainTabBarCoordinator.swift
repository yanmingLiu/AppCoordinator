//
//  MainTabBarCoordinator.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

protocol MainTabBarCoordinatorDelegate: AnyObject {
    func didFinish()
}

final class MainTabBarCoordinator: Coordinator {
    var navigation: Navigation

    private let factory: MainTabBarFactory
    private weak var delegate: MainTabBarCoordinatorDelegate?

    private var coordinators: [Coordinator] = []

    init(
        navigation: Navigation,
        factory: MainTabBarFactory,
        delegate: MainTabBarCoordinatorDelegate?
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }

    func start() {
        let tabBarcontroller = factory.makeMainTabBarController()
        navigation.navigationBar.isHidden = true
        navigation.push(tabBarcontroller, animated: false)

        let settingCoordinator = factory.makeSettingCoordinator(delegate: self)
        let homeCoordinator = factory.makeHomeCoordinator()
        let myPostCoordinator = factory.makeMyPostsoordinator()

        coordinators = [homeCoordinator, myPostCoordinator, settingCoordinator]
        coordinators.forEach { $0.start() }

        tabBarcontroller.viewControllers = coordinators.map(\.navigation.rootViewController)
    }
}

extension MainTabBarCoordinator: SettingsCoordinatorDelegate {
    func didLogOut() {
        delegate?.didFinish()
    }
}
