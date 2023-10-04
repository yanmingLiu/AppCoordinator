//
//  MyPostsViewController.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import UIKit

protocol MyPostsViewControllerDelegate: AnyObject {
    func didSelectPost(id: Int)
    func didTapAddNewPostButton()
}

class MyPostsViewController: UICollectionViewController {
    enum Section: CaseIterable {
        case main
    }

    private let viewModel: MyPostsViewModel
    private weak var delegate: MyPostsViewControllerDelegate?

    private var dataSource: UICollectionViewDiffableDataSource<Section, PostItemViewModel>!

    init(
        viewModel: MyPostsViewModel,
        delegate: MyPostsViewControllerDelegate?,
        collectionViewLayout: UICollectionViewLayout
    ) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(collectionViewLayout: collectionViewLayout)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupUI()
        setupBehaviours()
        setupDataSource()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

extension MyPostsViewController {
    func addNewPost(title: String) {
        viewModel.addNewPost(title: title)
    }
}

extension MyPostsViewController {
    private func setupUI() {
        let addItem = UIBarButtonItem(
            systemItem: .add,
            primaryAction: addNewPostAction()
        )
        navigationItem.rightBarButtonItem = addItem
    }

    private func setupBehaviours() {
        addBehaviors([NavigationBarLargeTitleBehaviors()])
    }
}

extension MyPostsViewController {
    private func setupDataSource() {
        let listCellRegistration = UICollectionView
            .CellRegistration<PostItemCell, PostItemViewModel> { cell, _, itemIdentifier in
                cell.fill(with: itemIdentifier)
            }

        dataSource = UICollectionViewDiffableDataSource<Section, PostItemViewModel>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                collectionView.dequeueConfiguredReusableCell(
                    using: listCellRegistration,
                    for: indexPath,
                    item: itemIdentifier
                )
            }
        )
    }

    private func bind(to viewModel: MyPostsViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.updateItems()
        }
    }

    private func updateItems() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PostItemViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.items.value)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Delegates

extension MyPostsViewController {
    override func collectionView(
        _: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        viewModel.didSelectItem(at: indexPath.row)
        delegate?.didSelectPost(id: indexPath.row)
    }
}

// MARK: - Actions

extension MyPostsViewController {
    private func addNewPostAction() -> UIAction {
        UIAction { [weak self] _ in
            self?.delegate?.didTapAddNewPostButton()
        }
    }
}
