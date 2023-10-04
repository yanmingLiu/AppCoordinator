//
//  MyPostsFactory.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import UIKit

struct MyPostsFactory {
    func makeMyPostViewController(
        delegate: MyPostsViewControllerDelegate)
        -> UIViewController
    {
        let viewModel = MyPostsViewModelImp()
        let controller = MyPostsViewController(
            viewModel: viewModel,
            delegate: delegate,
            collectionViewLayout: createLayout()
        )
        controller.title = "My Post"
        return controller
    }

    func makeNewPostCoordinator(
        delegate: NewPostViewControllerDelegate)
        -> UIViewController
    {
        let viewModel = NewPostViewModelImp()
        return NewPostViewController(viewModel: viewModel, delegate: delegate)
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

extension MyPostsFactory {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let padding: CGFloat = 16
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = padding
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(250)
            )
            let group = NSCollectionLayoutGroup
                .horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = padding
            section.contentInsets.trailing = padding
            section.interGroupSpacing = padding

            return section

        }, configuration: config)

        return layout
    }
}
