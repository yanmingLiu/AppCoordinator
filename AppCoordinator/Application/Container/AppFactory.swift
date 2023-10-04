//
//  AppFactory.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

struct AppFactory {
    let appDICoordinator: AppDICoordinator?

    func makeLogInCoordinator(
        navigation: Navigation,
        delegate: LogInCoordinatorDelegate?
    ) -> Coordinator {
        let logInFactory = LogInFactory(appDICoordinator: appDICoordinator)
        let coordinator = LogInCoordinator(
            navigation: navigation,
            factory: logInFactory,
            delegate: delegate
        )
        return coordinator
    }

    func makeMainTabBarCoordinator(
        navigation: Navigation,
        delegate: MainTabBarCoordinatorDelegate
    ) -> Coordinator {
        let factory = MainTabBarFactory(appDICoordinator: appDICoordinator)
        return MainTabBarCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate
        )
    }
}
