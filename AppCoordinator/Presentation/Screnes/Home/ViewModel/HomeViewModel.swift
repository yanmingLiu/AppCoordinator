//
//  HomeViewModel.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import Foundation

protocol HomeViewModel {
    // MARK: Input

    func viewDidLoad()
    func didSelectItem(at index: Int)

    // MARK: Output

    var items: Observable<[PostItemViewModel]> { get }
}

final class HomeViewModelImp {
    var items: Observable<[PostItemViewModel]> = Observable([])

    private func loadData() {
        (0 ... 99).forEach {
            let item = PostItemViewModel(
                id: $0,
                title: "\($0) post title",
                icon: "HongKong",
                authorAvatar: "person.crop.circle"
            )
            items.value.append(item)
        }
    }
}

extension HomeViewModelImp: HomeViewModel {
    func viewDidLoad() {
        loadData()
    }

    func didSelectItem(at _: Int) {}
}
