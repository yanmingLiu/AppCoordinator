//
//  MyPostsViewModel.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/30.
//

import Foundation

protocol MyPostsViewModel {
    // MARK: Input

    func viewDidLoad()
    func didSelectItem(at index: Int)
    func addNewPost(title: String)

    // MARK: Output

    var items: Observable<[PostItemViewModel]> { get }
}

final class MyPostsViewModelImp {
    var items: Observable<[PostItemViewModel]> = Observable([])

    private func loadData() {
//        (0...99).forEach {
//            let item = PostItemViewModel(
//                id: $0,
//                title: "\($0) post title",
//                icon: "HongKong",
//                authorAvatar: "person.crop.circle")
//            items.value.append(item)
//        }
    }
}

extension MyPostsViewModelImp: MyPostsViewModel {
    func viewDidLoad() {
        loadData()
    }

    func didSelectItem(at _: Int) {}

    func addNewPost(title: String) {
        let id = items.value.count + 1
        let item = PostItemViewModel(
            id: id,
            title: "ID:\(id) \(title)",
            icon: "HongKong",
            authorAvatar: "person.crop.circle"
        )
        items.value.append(item)
    }
}
