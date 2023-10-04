//
//  PostDetailFactory.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import UIKit

struct PostDetailFactory {
    private(set) var id: Int

    func makePostDetailViewController(
        delegate: PostDetailViewControllerDelegate
    ) -> UIViewController {
        let controller = PostDetailViewController(delegate: delegate)
        controller.navigationItem.title = "Post:\(id)"
        return controller
    }

    func makePhotosViewController() -> UIViewController {
        let controller = UIViewController()
        controller.navigationItem.title = "Photos"
        controller.view.backgroundColor = .systemBackground
        let navigation = UINavigationController(rootViewController: controller)
        return navigation
    }
}
