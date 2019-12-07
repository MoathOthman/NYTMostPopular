//
//  MostPopularModelLayerTests.swift
//  NYTMostVPopularArticlesTests
//
//  Created by Moath_Othman on 12/9/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Nimble
@testable import NYTMostVPopularArticles
import RxSwift
import XCTest

class MostPopularModelLayerTests: XCTestCase {

    var sut: MostPopularModelLayer!
    var apiMock = NYTAPIClientMock()
    let bag = DisposeBag()

    override func setUp() {
        super.setUp()
        apiMock = NYTAPIClientMock()
        sut = MostPopularModelLayer(api: apiMock )
    }

    func testGetArticles_shouldCallGetArticlesApi() {
        // when
        sut.getArticles().subscribe().disposed(by: bag)
        // then
        expect(self.apiMock.wasgetMostPopularArticlesCalled) == true
    }

    func testGetArticles_whenValidResponse_shouldReturnArticlesWithMatchingCount() {
        // given
        apiMock.getMostPopularArticlesStub = Observable<Any>.just(parseJSON(name: "articles"))
        // when
        sut.getArticles()
            .subscribe(onNext: { articles in
                // then
                expect(articles).toNot(beNil())
                expect(articles).toNot(beEmpty())
                expect(articles?.count).to(be(1))
            }).disposed(by: bag)
    }
}
