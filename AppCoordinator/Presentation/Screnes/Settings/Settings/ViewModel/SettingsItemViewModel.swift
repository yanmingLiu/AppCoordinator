//
//  SettingsItemViewModel.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import Foundation

enum SettingsNavigation: String {
    case userConfig
    case account
    case theme
    case logOut
    case about
    case noNavigation
}

struct SettingsItemViewModel: Hashable {
    let title: String
    let icon: String
    let isNavigation: Bool
    let navigation: SettingsNavigation
}
