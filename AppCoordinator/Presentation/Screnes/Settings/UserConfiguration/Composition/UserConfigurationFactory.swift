//
//  UserConfigurationFactory.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import Photos
import PhotosUI
import UIKit

struct UserConfigurationFactory {
    let appDICoordinator: AppDICoordinator?

    init(appDICoordinator: AppDICoordinator?) {
        self.appDICoordinator = appDICoordinator
    }

    func makeUserConfigurationViewController(
        delegate: UserConfigurationControllerDelegate
    ) -> UIViewController {
        let viewModel = UserConfigurationViewModelImp()
        let controller = UserConfigurationController(viewModel: viewModel, delegate: delegate)
        controller.title = "User Configuration"
        return controller
    }

    func makePhotoViewController() -> UIViewController {
        let controller = UIViewController()
        controller.navigationItem.title = "Photos"
        controller.view.backgroundColor = .systemBackground
        return controller
    }
}
