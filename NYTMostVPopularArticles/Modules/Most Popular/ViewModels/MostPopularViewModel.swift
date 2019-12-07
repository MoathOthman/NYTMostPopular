//
//  MostPopularViewModel.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/5/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation
import RxSwift

protocol MostPopularViewModelProtocol {
    func fetchData()
    func cellViewModel(forIndex index: IndexPath) -> MostPopularCellViewModel
    func article(forIndex index: IndexPath) -> Article
    func numbersOfRows(forSection section: Int) -> Int
    
    var loading: Observable<Bool> { get }
}

class MostPopularViewModel: MostPopularViewModelProtocol {

    let model: MostPopularModelLayerProtocol
    let bag = DisposeBag()
    private(set) var items: BehaviorSubject<[Article]> = BehaviorSubject<[Article]>(value: [])
    var loading: Observable<Bool> { return _loading.asObservable() }
    private let _loading = PublishSubject<Bool>()

    init(model: MostPopularModelLayerProtocol) {
        self.model = model
    }

    func fetchData() {
        _loading.onNext(true)
        model.getArticles()
            .do(onError: { _ in
                self._loading.onNext(false)
            }, onCompleted: {
                self._loading.onNext(false)
            })
            .compactMap({ $0 })
            .bind(to: items)
            .disposed(by: bag)
    }

    func cellViewModel(forIndex index: IndexPath) -> MostPopularCellViewModel {
        guard let item = try? self.items.value()[index.row] else { fatalError("no item for index") }
        return MostPopularCellViewModel(title: item.title,
                                        publishedBy: item.byline,
                                        publishedOn: item.publishedDate,
                                        viewsNumber: item.views)
    }

    func article(forIndex index: IndexPath) -> Article {
        guard let item = try? self.items.value()[index.row] else { fatalError("no item for index") }
        return item
    }

    func numbersOfRows(forSection section: Int) -> Int {
        guard let count = try? items.value().count else { return 0 }
        return count
    }
}

struct MostPopularCellViewModel: Equatable {
    let title: String
    let publishedBy: String
    let publishedOn: String
    let viewsNumber: Int
}
