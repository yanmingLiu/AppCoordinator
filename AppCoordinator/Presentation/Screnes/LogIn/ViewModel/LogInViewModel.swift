//
//  LogInViewModel.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import Foundation

final class LogInViewModel {
    var logInAuth: LogInUserCase?

    init(loginAuth: LogInUserCase?) {
        logInAuth = loginAuth
    }

    func logIn() {
        logInAuth?.logIn()
    }
}
