//
//  SettingsFactory.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

struct SettingsFactory {
    let appDICoordinator: AppDICoordinator?

    func makeSettingsViewController(
        delegate: SettingsViewControllerDelegate?
    ) -> UIViewController {
        let viewModel = SettingsViewModelImp(auth: appDICoordinator?.auth)
        let controller = SettingsViewController(
            viewModel: viewModel,
            delegate: delegate,
            collectionViewLayout: createLayout()
        )
        controller.title = "Settings"
        return controller
    }

    func makeDetailViewController(
        title: String
    ) -> UIViewController {
        let controller = UIViewController()
        controller.title = title
        controller.view.backgroundColor = .systemBackground
        return controller
    }

    func makeUserConfigurationCoordinator(
        delegate: UserConfigurationCoordinatorDelegate
    ) -> Coordinator {
        let factory = UserConfigurationFactory(appDICoordinator: appDICoordinator)
        let navigation = NavigationImp(rootViewController: UINavigationController())
        let coordinator = UserConfigurationCoordinator(navigation: navigation, factory: factory, delegate: delegate)
        return coordinator
    }
}

extension SettingsFactory {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let padding: CGFloat = 16
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = padding
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: { _, _ in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                )
                let group = NSCollectionLayoutGroup
                    .horizontal(layoutSize: groupSize,
                                subitems: [item])
                group.interItemSpacing = .fixed(padding)
                group.contentInsets.trailing = padding

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = padding
                section.contentInsets.trailing = padding
                section.interGroupSpacing = padding

                return section

            }, configuration: config
        )

        return layout
    }
}
