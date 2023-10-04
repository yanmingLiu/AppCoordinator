//
//  Coordinator.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigation: Navigation { get set }

    func start()
}
