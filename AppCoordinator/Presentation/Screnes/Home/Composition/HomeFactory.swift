//
//  HomeFactory.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

struct HomeFactory {
    var appDICoordinator: AppDICoordinator?

    func makeHomeViewController(
        delegate: HomeViewControllerDelegate
    ) -> UIViewController {
        let viewModel = HomeViewModelImp()
        let controller = HomeViewController(
            viewModel: viewModel,
            delegate: delegate,
            collectionViewLayout: createLayout()
        )
        controller.title = "Home"
        return controller
    }

    func makePostDetailCoordinator(
        navigation: Navigation,
        id: Int,
        parentCoordinator: ParentCoordinator
    ) -> Coordinator {
        let factory = PostDetailFactory(id: id)
        return PostDetailCoordinator(
            navigation: navigation,
            factory: factory,
            parentCoordinator: parentCoordinator
        )
    }
}

extension HomeFactory {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let padding: CGFloat = 16
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = padding
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: { _, _ in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(250)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(250)
                )
                let group = NSCollectionLayoutGroup
                    .horizontal(layoutSize: groupSize,
                                subitems: [item])

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
