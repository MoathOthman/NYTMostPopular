//
//  NYTAPIClientTests.swift
//  NYTMostVPopularArticlesTests
//
//  Created by Moath_Othman on 12/9/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Mockingjay
import Nimble
@testable import NYTMostVPopularArticles
import RxSwift
import XCTest

class NYTAPIClientTests: XCTestCase {
    var sut: NYTAPIClient!
    let bag = DisposeBag()
    var stub: Stub!
    var apiresponse: Any?
    var apierror: Any?

    override func setUp() {
        super.setUp()
        sut = NYTAPIClient()
        apiresponse = nil
        apierror = nil
    }

    override func tearDown() {
        if stub != nil {
            self.removeStub(stub)
        }
        super.tearDown()
    }

    func testGetMostPopularArticles_OnSuccess_shouldReturnNonilResponseAndNilError() {
        let period = "1"
        let url = "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=ReF1cYEk6EGjiNzMxIbATloGhiCcB9xE"
        stub = self.stub(uri(url),
                         json(parseJSON(name: "articles")))
        sut.getMostPopularArticles(period: period).subscribe { event in
            switch event {
            case .completed:
                break
            case .error(let error):
                self.apierror = error
            case .next(let element):
                self.apiresponse = element
            }
        }.disposed(by: bag)
        expect(self.apiresponse).toEventuallyNot(beNil())
        expect(self.apierror).toEventually(beNil())
    }

    func testGetMostPopularArticles_OnFail_shouldReturnNonilErrorAndNilResponse() {
        let period = "1"

        let error = NSError(domain: "domain", code: 2323, userInfo: nil)
        stub = self.stub(everything, failure(error))
        sut.getMostPopularArticles(period: period).subscribe { event in
            switch event {
            case .completed:
                break
            case .error(let error):
                self.apierror = error
            case .next(let element):
                self.apiresponse = element
            }
        }.disposed(by: bag)
        expect(self.apierror).toEventuallyNot(beNil())
        expect(self.apiresponse).toEventually(beNil())
    }
}
