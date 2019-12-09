//
//  UserDetails+LayoutTest.swift
//  GithubTests
//
//  Created by moath on 4/13/18.
//  Copyright © 2018 moath othman. All rights reserved.
//

import LayoutTest
import Nimble
@testable import NYTMostVPopularArticles
import RxSwift
import XCTest

private func setupView() -> ArticleViewController {
    let viewController = ArticleViewController.instantiatedView()
    viewController.viewModel = ArticleViewModel(article: ArticleFake.fakeArticle)
    return viewController
}

var counter  = 0
extension ArticleViewController: ViewProvider {
    public static func dataSpecForTest() -> [AnyHashable : Any] {
        return ["title": StringValues(),
                "source": StringValues(),
                "by": StringValues(),
                "at": StringValues(),
                "views": IntegerValues(required: true),
        ]
    }

    public static func sizesForView() -> [ViewSize] {
        return [
            ViewSize(width: LYTiPhone6PlusWidth),
            ViewSize(width: LYTiPhone6PlusHeight),
        ]
    }

    public static func view(forData data: [AnyHashable : Any], reuse reuseView: UIView?, size: ViewSize?, context: AutoreleasingUnsafeMutablePointer<AnyObject?>?) -> UIView {
        counter += 1
        print(counter)
        let title = data["title"] as? String
        let views = data["views"] as? Int
        let source = data["source"] as? String
        let by = data["by"] as? String
        let at = data["at"] as? String

        let viewController = setupView()
        _ = viewController.view
        viewController.titleLabel.text = title
        viewController.sourceLabel.text = source
        viewController.viewsNumber.text = "\(views ?? 0)"
        viewController.publishedBy.text = by
        viewController.publishedOn.text = at
        
        context?.pointee = viewController
        return viewController.view
    }

}

class ArticleViewControllerLayoutTests: LayoutTestCase {

    func testLayout() {
        self.failingTestSnapshotsEnabled = true
        runLayoutTests(withViewProvider: ArticleViewController.self, limitResults: .limitDataCombinations) { view, data, context in
            let viewController = context as! ArticleViewController
            XCTAssertTrue(viewController.titleLabel.lyt_above(viewController.sourceLabel))
            XCTAssertTrue(viewController.titleLabel.lyt_above(viewController.publishedBy))
            XCTAssertTrue(viewController.publishedBy.lyt_above(viewController.sourceLabel))
            XCTAssertTrue(viewController.sourceLabel.lyt_above(viewController.publishedOn))
            XCTAssertTrue(viewController.publishedOn.lyt_below(viewController.publishedBy))
            XCTAssertTrue(viewController.viewsNumber.lyt_below(viewController.sourceLabel))
        }

    }
}

