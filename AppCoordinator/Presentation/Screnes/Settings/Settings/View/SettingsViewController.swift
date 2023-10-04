//
//  SettingsViewController.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func showSettingsDetails(_: SettingsItemViewModel)
}

class SettingsViewController: UICollectionViewController {
    enum Section: CaseIterable {
        case main
    }

    private let viewModel: SettingsViewModel
    private weak var delegate: SettingsViewControllerDelegate?

    private var dataSource: UICollectionViewDiffableDataSource<Section, SettingsItemViewModel>!

    init(
        viewModel: SettingsViewModel,
        delegate: SettingsViewControllerDelegate?,
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

extension SettingsViewController {
    private func setupUI() {}

    private func setupBehaviours() {
        addBehaviors([NavigationBarLargeTitleBehaviors()])
    }
}

extension SettingsViewController {
    private func setupDataSource() {
        let listCellRegistration = UICollectionView.CellRegistration<SettingsCell, SettingsItemViewModel> { cell, _, itemIdentifier in
            cell.fill(with: itemIdentifier)
        }

        dataSource = UICollectionViewDiffableDataSource<Section, SettingsItemViewModel>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: itemIdentifier)
        })
    }

    private func bind(to viewModel: SettingsViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.updateItems()
        }
    }

    private func updateItems() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SettingsItemViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.items.value)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension SettingsViewController {
    override func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
        delegate?.showSettingsDetails(viewModel.items.value[indexPath.row])
    }
}
