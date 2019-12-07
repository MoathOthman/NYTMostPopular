//
//  ArticleResponseTests.swift
//  NYTMostVPopularArticlesTests
//
//  Created by Moath_Othman on 12/9/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation
import Nimble
@testable import NYTMostVPopularArticles
import XCTest

//swiftlint:disable force_try
class ArticleResponseTests: XCTestCase {

    func testDecoding_GivenValidJSON_shouldNotThrowAndError() throws {
        let json = parseJSON(name: "articles")
        let decoder = JSONDecoder()
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)

        expect(try decoder.decode(ArticlesResponse.self, from: jsonData))
            .toNot(throwError())
    }
}
