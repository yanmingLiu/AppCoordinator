//
//  HomeCoordinator.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigation: Navigation
    private let factory: HomeFactory
    var childCoordinators: [Coordinator] = []

    init(
        navigation: Navigation,
        factory: HomeFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }

    func start() {
        let controller = factory.makeHomeViewController(delegate: self)
        navigation
            .rootViewController
            .pushViewController(controller, animated: true)

        let item = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        navigation.rootViewController.tabBarItem = item
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func didSelectPost(id: Int) {
        let postDetailCoordinator = factory
            .makePostDetailCoordinator(
                navigation: navigation,
                id: id,
                parentCoordinator: self
            )
        addChildCoordinatorStar(postDetailCoordinator)
    }
}

extension HomeCoordinator: ParentCoordinator {}
