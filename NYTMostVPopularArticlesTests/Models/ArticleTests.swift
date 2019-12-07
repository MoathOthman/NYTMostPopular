//
//  ArticleTests.swift
//  NYTMostVPopularArticlesTests
//
//  Created by Moath_Othman on 12/9/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Nimble
@testable import NYTMostVPopularArticles
import XCTest

//swiftlint:disable force_try
class ArticleTests: XCTestCase {

    func testDecoding_GivenValidJSON_shouldNotThrowAndError() throws {
        let json = parseJSON(name: "article")
        let decoder = JSONDecoder()
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)

        expect(try decoder.decode(Article.self, from: jsonData))
            .toNot(throwError())
    }
}
