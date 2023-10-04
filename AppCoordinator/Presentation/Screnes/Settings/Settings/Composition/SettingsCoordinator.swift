//
//  SettingsCoordinator.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

protocol SettingsCoordinatorDelegate: AnyObject {
    func didLogOut()
}

final class SettingsCoordinator: Coordinator {
    var navigation: Navigation
    private let factory: SettingsFactory
    private weak var delegate: SettingsCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []

    init(navigation: Navigation,
         factory: SettingsFactory,
         delegate: SettingsCoordinatorDelegate?)
    {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }

    func start() {
        let controller = factory.makeSettingsViewController(delegate: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.push(controller, animated: true)

        let item = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape.2"),
            selectedImage: UIImage(systemName: "gearshape.2.fill")
        )
        navigation.rootViewController.tabBarItem = item
    }
}

extension SettingsCoordinator: SettingsViewControllerDelegate {
    func showSettingsDetails(_ item: SettingsItemViewModel) {
        print("showSettingsDetails:\(item.title)")

        let controller = factory.makeDetailViewController(title: item.title)

        switch item.navigation {
        case .userConfig:
            callUserConfigurationCoordinator()
        case .account:
            navigation.push(controller, animated: true)
        case .theme:
            navigation.push(controller, animated: true)
        case .logOut:
            delegate?.didLogOut()
        case .about:
            navigation.push(controller, animated: true)
        case .noNavigation:
            break
        }
    }
}

extension SettingsCoordinator {
    private func callUserConfigurationCoordinator() {
        let userConfigurationCoordinator = factory
            .makeUserConfigurationCoordinator(delegate: self)
        addChildCoordinatorStar(userConfigurationCoordinator)
        navigation.present(
            userConfigurationCoordinator.navigation.rootViewController,
            animated: true
        )

        // FIXME: ⚠️内存释放问题：这里SettingsCoordinator持有了userConfigurationCoordinator，在手势滑动关闭present VC后userConfigurationCoordinator未释放的问题。
        userConfigurationCoordinator
            .navigation
            .dismissNavigation = { [weak self] in
                self?.removeChildCoordinator(userConfigurationCoordinator)
            }
    }
}

extension SettingsCoordinator: UserConfigurationCoordinatorDelegate {
    func didFinishFlow(_ childCoordinator: Coordinator) {
        // FIXME: ⚠️内存释放问题：这里SettingsCoordinator持有了userConfigurationCoordinator，在按钮关闭present VC后userConfigurationCoordinator未释放的问题。
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: true)
    }
}

extension SettingsCoordinator: ParentCoordinator {}
