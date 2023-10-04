//
//  MyPostsCoordinator.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import UIKit

final class MyPostsCoordinator: Coordinator {
    var navigation: Navigation
    private let factory: MyPostsFactory
    var childCoordinators: [Coordinator] = []

    init(
        navigation: Navigation,
        factory: MyPostsFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }

    func start() {
        let controller = factory.makeMyPostViewController(delegate: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.push(controller, animated: true)

        let item = UITabBarItem(
            title: "My Posts",
            image: UIImage(systemName: "list.dash.header.rectangle"),
            selectedImage: UIImage(systemName: "list.bullet.rectangle.fill")
        )
        navigation.rootViewController.tabBarItem = item
    }
}

extension MyPostsCoordinator: MyPostsViewControllerDelegate {
    func didSelectPost(id: Int) {
        let postDetailCoordinator = factory
            .makePostDetailCoordinator(
                navigation: navigation,
                id: id,
                parentCoordinator: self
            )
        addChildCoordinatorStar(postDetailCoordinator)
    }

    func didTapAddNewPostButton() {
        let controller = factory.makeNewPostCoordinator(delegate: self)
        navigation.present(controller, animated: true)
    }
}

extension MyPostsCoordinator: NewPostViewControllerDelegate {
    func didSaveNewPost(title: String) {
        navigation.dismiss(animated: true)
        addNewPost(title: title)
    }
}

extension MyPostsCoordinator {
    private func addNewPost(title: String) {
        guard let controller = navigation
            .rootViewController
            .topViewController as? MyPostsViewController
        else { return }
        controller.addNewPost(title: title)
    }
}

extension MyPostsCoordinator: ParentCoordinator {}
