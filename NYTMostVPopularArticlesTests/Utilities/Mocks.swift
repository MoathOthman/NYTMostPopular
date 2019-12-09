//  NYTAPIClientMock.swift
//  NYTMostVPopularArticlesTests
//
//  Created by Moath_Othman on 12/9/19.
//  Copyright © 2019 moath. All rights reserved.
//

@testable import NYTMostVPopularArticles
import RxSwift
import XCTest

class NYTAPIClientMock: APIClient {

    var getMostPopularArticlesStub = Observable<Any>.just(0)

    func getMostPopularArticles(period: String) -> Observable<Any> {
        wasgetMostPopularArticlesCalled = true
        self.periodStub = period
        return getMostPopularArticlesStub
    }

    private(set) var wasgetMostPopularArticlesCalled = false
    var periodStub = ""

    func reset() {
        wasgetMostPopularArticlesCalled = false
        periodStub = ""
    }
}

class ArticleFake {
    static var fakeArticle: Article {
        return Article(abstractField: "", byline: "", id: 2, publishedDate: "", source: "", title: "", views: 2, url: "rre")
    }

    static var fakeArticleForDan: Article {
        return Article(abstractField: "", byline: "DAN", id: 2, publishedDate: "", source: "", title: "", views: 2, url: "rre")
    }

    static var articleForLayoutTest: Article {
        return Article(abstractField: """
A member of the Saudi Air Force training to be a
 pilot killed three people at Naval Air Station Pensacola before he
was shot dead by officers responding to the scene, the authorities said.
""",
                       byline: "PATRICIA MAZZEI, THOMAS GI",
                       id: 2,
                       publishedDate: "2009-03-13",
                       source: "Moath othman",
                       title: "Trainee on Military Base Mounts Deadly Attack",
                       views: 2, url: "rre")
    }
}

class MostPopularModalLayerMock: MostPopularModelLayerProtocol {

    private(set) var wasGetArticlesCalled = false
    var getArticlesReturnStub = Observable<[Article]?>.just([ArticleFake.fakeArticle])

    func getArticles() -> Observable<[Article]?> {
        wasGetArticlesCalled = true
        return getArticlesReturnStub
    }
}

class MostPopularViewModelMock: MostPopularViewModelProtocol {

    private(set) var fetchDataCalled = false
    private(set) var cellViewModelForIndexCalled = false
    private(set) var articleForIndexCalled = false
    private(set) var numbersOfRowsCalled = false
    private(set) var indexSpy = IndexPath(row: 0, section: 0)
    var returnedArticleStub = ArticleFake.fakeArticle

    func fetchData() {
        fetchDataCalled = true
    }

    func cellViewModel(forIndex index: IndexPath) -> MostPopularCellViewModel {
        cellViewModelForIndexCalled = true
        return MostPopularCellViewModel(title: "", publishedBy: "", publishedOn: "", viewsNumber: 1)
    }

    func article(forIndex index: IndexPath) -> Article {
        articleForIndexCalled = true
        self.indexSpy = index
        return returnedArticleStub
    }

    func numbersOfRows(forSection section: Int) -> Int {
        numbersOfRowsCalled = true
        return 0
    }

    var loading: Observable<Bool> {
        Observable.just(true)
    }

}

class TableViewMock: UITableView {
    private(set) var cellDequeuedWasCalled: Bool = false

    override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell {
        cellDequeuedWasCalled = true
        return super.dequeueReusableCell(withIdentifier: identifier)!
    }

    class func initializeTableViewMock() -> TableViewMock {
        let tableViewMock = TableViewMock(frame: CGRect(x: 0, y: 0, width: 300, height: 500), style: .plain)
        tableViewMock.register(MostPopularTableViewCellMock.self, forCellReuseIdentifier: "mostpopular")

        return tableViewMock
    }
}

class MostPopularTableViewCellMock: MostPopularTableViewCell {
    private(set) var configureWasCalled = false
    private(set) var viewModel: MostPopularCellViewModel!

    override func configure(viewModel: MostPopularCellViewModel) {
        configureWasCalled = true
        self.viewModel = viewModel
    }
}

class MainCoordinatorMock: MainCoordinator {

    private(set) var articleSpy: Article!
    private(set) var routeToArticleDetailsCalled: Bool!

    override func routeToArticleDetails(article: Article) {
        self.articleSpy = article
        routeToArticleDetailsCalled = true
    }
}
