//
//  NavigationBarLargeTitleBehaviors.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/15.
//

import UIKit

struct NavigationBarLargeTitleBehaviors: ViewControllerLifecycleBehavior {
    func viewDidLoad(viewController: UIViewController) {
        viewController
            .navigationController?
            .navigationBar
            .prefersLargeTitles = true
    }
}
