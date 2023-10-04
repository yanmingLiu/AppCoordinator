//
//  PostDetailCoordinator.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import Foundation

final class PostDetailCoordinator: Coordinator {
    var navigation: Navigation
    private let factory: PostDetailFactory
    private var parentCoordinator: ParentCoordinator?

    init(
        navigation: Navigation,
        factory: PostDetailFactory,
        parentCoordinator: ParentCoordinator
    ) {
        self.navigation = navigation
        self.factory = factory
        self.parentCoordinator = parentCoordinator
    }

    func start() {
        let controller = factory.makePostDetailViewController(delegate: self)

        navigation.push(controller, animated: true) { [weak self] in
            guard let self else { return }
            // FIXME: - ⚠️内存释放问题：这里需要由上级的coordinator 移除掉子coordinator引用，上级 Coordinator引用了detail的coordinator, 在detail pop后需要移除
            parentCoordinator?.removeChildCoordinator(self)
        }
    }
}

extension PostDetailCoordinator: PostDetailViewControllerDelegate {
    func didTapPhotoButton() {
        let controller = factory.makePhotosViewController()
        navigation.present(controller, animated: true)
    }
}
