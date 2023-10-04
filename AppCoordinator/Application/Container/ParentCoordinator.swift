//
//  ParentCoordinator.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

protocol ParentCoordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
}

extension ParentCoordinator {
    func addChildCoordinatorStar(_ childCoordinator: Coordinator?) {
        guard let childCoordinator else { return }
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }

    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }

    func clearAllChildCoordinators() {
        childCoordinators = []
    }
}
