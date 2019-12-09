//
//  MostPopularViewModelTests.swift
//  NYTMostVPopularArticlesTests
//
//  Created by Moath_Othman on 12/9/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Nimble
@testable import NYTMostVPopularArticles
import RxSwift
import XCTest

class MostPopularViewModelTests: XCTestCase {

    var sut: MostPopularViewModel!
    var modelLayerMock: MostPopularModalLayerMock!
    let bag = DisposeBag()

    override func setUp() {
        super.setUp()
        modelLayerMock = MostPopularModalLayerMock()
        sut = MostPopularViewModel(model: modelLayerMock)
    }

    func testFetchData_shouldCallGetArticlesAndStartLoading() {
        var loadingWasSignaled = false
        // given
        sut.loading.subscribe(onNext: { _ in
            // then
            loadingWasSignaled = true
        }).disposed(by: bag)
        // when
        sut.fetchData()
        // then
        expect(self.modelLayerMock.wasGetArticlesCalled) == true
        expect(loadingWasSignaled).toEventually(beTrue())
    }

    func testFetchData_whenArticlesAreFetched_shouldStopLoadingSignalAndFillItems() {
        var loadingSignalSpy: Bool!
        var itemsSubjectSpy: [Article]!
        // given

        modelLayerMock.getArticlesReturnStub = Observable.just([ArticleFake.fakeArticle])
        sut.loading.subscribe(onNext: { value in
            loadingSignalSpy = value
        }).disposed(by: bag)

        sut.items.subscribe(onNext: { articles in
            // then
            itemsSubjectSpy = articles
        }).disposed(by: bag)          // when
        sut.fetchData()
        // then
        expect(loadingSignalSpy).toEventually(beFalse())
        expect(itemsSubjectSpy).toEventually(equal([ArticleFake.fakeArticle]))
    }

    func testArticleForIndex_availableItem_shouldReturnMatchingArticle() {
        // given
        sut.items.onNext([ArticleFake.fakeArticle, ArticleFake.fakeArticleForDan])
        let secondIndex = IndexPath(row: 1, section: 0)
        // when
        let article = sut.article(forIndex: secondIndex)
        // then
        expect(article) == ArticleFake.fakeArticleForDan
    }

    func testCellViewModelForIndex_availableItem_shouldReturnMatchingViewModel() {
        // give
        sut.items.onNext([ArticleFake.fakeArticle, ArticleFake.fakeArticleForDan])
        let secondIndex = IndexPath(row: 1, section: 0)
        // when
        let cellViewModel = sut.cellViewModel(forIndex: secondIndex)
        // then
        expect(cellViewModel) == MostPopularCellViewModel(title: ArticleFake.fakeArticleForDan.title,
                                                          publishedBy: ArticleFake.fakeArticleForDan.byline,
                                                          publishedOn: ArticleFake.fakeArticleForDan.publishedDate,
                                                          viewsNumber: ArticleFake.fakeArticleForDan.views)
    }
}
