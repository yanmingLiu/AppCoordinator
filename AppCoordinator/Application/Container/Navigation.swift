//
//  Navigation.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import UIKit

protocol Navigation {
    var rootViewController: UINavigationController { get }
    var viewControllers: [UIViewController] { get set }
    var navigationBar: UINavigationBar { get }
    func present(_ viewController: UIViewController, animated: Bool)
    func push(
        _ viewController: UIViewController,
        animated: Bool,
        backCompletion: (() -> Void)?
    )
    func dismiss(animated: Bool)
    var dismissNavigation: (() -> Void)? { get set }
}

extension Navigation {
    func push(_ viewController: UIViewController, animated: Bool) {
        push(viewController, animated: animated, backCompletion: nil)
    }
}

final class NavigationImp: NSObject {
    var rootViewController: UINavigationController
    var dismissNavigation: (() -> Void)?

    private var backCompletions: [UIViewController: () -> Void] = [:]

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        super.init()

        rootViewController.delegate = self
        rootViewController.presentationController?.delegate = self
    }
}

extension NavigationImp: Navigation {
    var viewControllers: [UIViewController] {
        get {
            rootViewController.viewControllers
        }
        set {
            rootViewController.viewControllers = newValue
        }
    }

    var navigationBar: UINavigationBar {
        rootViewController.navigationBar
    }

    func present(_ viewController: UIViewController, animated: Bool) {
        rootViewController.present(viewController, animated: animated)
    }

    func dismiss(animated: Bool) {
        rootViewController.dismiss(animated: animated)
    }

    func push(
        _ viewController: UIViewController,
        animated: Bool,
        backCompletion: (() -> Void)?
    ) {
        if let backCompletion {
            backCompletions[viewController] = backCompletion
        }
        rootViewController.pushViewController(viewController, animated: animated)
    }
}

extension NavigationImp: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow _: UIViewController,
        animated _: Bool
    ) {
        guard let controller = navigationController
            .transitionCoordinator?
            .viewController(forKey: .from),
            !navigationController.viewControllers.contains(controller)
        else { return }

        guard let completion = backCompletions[controller] else {
            return
        }
        completion()
        backCompletions.removeValue(forKey: controller)
    }
}

extension NavigationImp: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_: UIPresentationController) {
        dismissNavigation?()
        dismissNavigation = nil
    }
}
