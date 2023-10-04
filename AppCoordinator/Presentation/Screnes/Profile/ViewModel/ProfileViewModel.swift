//
//  ProfileViewModel.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import Foundation

protocol ProfileViewModel {
    func viewDidLoad()
}

final class ProfileViewModelImp {}

extension ProfileViewModelImp: ProfileViewModel {
    func viewDidLoad() {}
}
