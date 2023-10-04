//
//  HomeViewController.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didSelectPost(id: Int)
}

class HomeViewController: UICollectionViewController {
    enum Section: CaseIterable {
        case main
    }

    private let viewModel: HomeViewModel
    private weak var delegate: HomeViewControllerDelegate?

    private var dataSource: UICollectionViewDiffableDataSource<Section, PostItemViewModel>!

    init(
        viewModel: HomeViewModel,
        delegate: HomeViewControllerDelegate,
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

extension HomeViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }

    private func setupBehaviours() {
        addBehaviors([NavigationBarLargeTitleBehaviors()])
    }
}

extension HomeViewController {
    private func setupDataSource() {
        let listCellRegistration = UICollectionView
            .CellRegistration<PostItemCell, PostItemViewModel> { cell, _, itemIdentifier in
                cell.fill(with: itemIdentifier)
            }

        dataSource = UICollectionViewDiffableDataSource<Section, PostItemViewModel>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                collectionView
                    .dequeueConfiguredReusableCell(
                        using: listCellRegistration,
                        for: indexPath,
                        item: itemIdentifier
                    )
            }
        )
    }

    private func bind(to viewModel: HomeViewModel) {
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

extension HomeViewController {
    override func collectionView(
        _: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        viewModel.didSelectItem(at: indexPath.row)
        delegate?.didSelectPost(id: indexPath.row)
    }
}
