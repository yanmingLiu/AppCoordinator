//
//  Auth.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import Foundation

protocol AuthCheck {
    var isSessionActive: Bool { get }
}

final class Auth {
    private var session = false
}

extension Auth: AuthCheck {
    var isSessionActive: Bool {
        session
    }
}

extension Auth: LogInUserCase {
    func logIn() {
        session = true
    }
}

extension Auth: LogOutUserCase {
    func logOut() {
        session = false
    }
}
