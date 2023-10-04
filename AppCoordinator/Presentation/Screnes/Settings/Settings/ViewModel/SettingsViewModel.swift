//
//  SettingsViewModel.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import Foundation

protocol SettingsViewModel {
    // MARK: Input

    func viewDidLoad()
    func didSelectItem(at index: Int)

    // MARK: Output

    var items: Observable<[SettingsItemViewModel]> { get }
}

final class SettingsViewModelImp {
    var items: Observable<[SettingsItemViewModel]> = Observable([])

    private let auth: LogOutUserCase?

    init(auth: LogOutUserCase?) {
        self.auth = auth
    }

    private func loadData() {
        items.value = [
            SettingsItemViewModel(
                title: "User Configuration",
                icon: "person",
                isNavigation: true,
                navigation: .userConfig
            ),

            SettingsItemViewModel(
                title: "Account",
                icon: "archivebox.circle",
                isNavigation: true,
                navigation: .account
            ),

            SettingsItemViewModel(
                title: "Theme",
                icon: "paintbrush",
                isNavigation: true,
                navigation: .theme
            ),

            SettingsItemViewModel(
                title: "LogOut",
                icon: "door.right.hand.open",
                isNavigation: true,
                navigation: .logOut
            ),

            SettingsItemViewModel(
                title: "About",
                icon: "questionmark.circle",
                isNavigation: true,
                navigation: .about
            ),
        ]
    }
}

extension SettingsViewModelImp: LogOutUserCase {
    func logOut() {
        auth?.logOut()
    }
}

extension SettingsViewModelImp: SettingsViewModel {
    func viewDidLoad() {
        loadData()
    }

    func didSelectItem(at index: Int) {
        let item = items.value[index]
        if item.navigation == .logOut {
            auth?.logOut()
        }
    }
}
