//
//  MainTabBarFactory.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

struct MainTabBarFactory {
    var appDICoordinator: AppDICoordinator?

    func makeMainTabBarController() -> UITabBarController {
        MainTabBarController()
    }

    func makeSettingCoordinator(
        delegate: SettingsCoordinatorDelegate?
    ) -> Coordinator {
        let factory = SettingsFactory(appDICoordinator: appDICoordinator)
        let navigation = NavigationImp(rootViewController: UINavigationController())
        return SettingsCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate
        )
    }

    func makeHomeCoordinator() -> Coordinator {
        let factory = HomeFactory(appDICoordinator: appDICoordinator)
        let navigation = NavigationImp(rootViewController: UINavigationController())
        return HomeCoordinator(
            navigation: navigation,
            factory: factory
        )
    }

    func makeMyPostsoordinator() -> Coordinator {
        let factory = MyPostsFactory()
        let navigation = NavigationImp(rootViewController: UINavigationController())
        return MyPostsCoordinator(
            navigation: navigation,
            factory: factory
        )
    }
}
