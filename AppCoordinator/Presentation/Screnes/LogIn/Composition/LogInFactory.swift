//
//  LogInFactory.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

struct LogInFactory {
    let appDICoordinator: AppDICoordinator?

    func makeLogInViewController(delegate: LogInViewContollerDelegate?) -> UIViewController {
        let viewModel = LogInViewModel(loginAuth: appDICoordinator?.auth)
        return LogInViewContoller(viewModel: viewModel, delegate: delegate)
    }
}
