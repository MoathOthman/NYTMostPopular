//  XCTestCase.swift
//  NYTMostVPopularArticlesTests
//
//  Created by Moath_Othman on 12/9/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation
@testable import NYTMostVPopularArticles
import XCTest
//swiftlint:disable force_try force_cast
extension XCTestCase {
    func parse(name: String) -> Any {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
    }

    func parseJSON(name: String) -> [String: Any] {
        return parse(name: name) as! [String: Any]
    }

    func parseJSONArray(name: String) -> [[String: Any]] {
        return parse(name: name) as! [[String: Any]]
    }
}
