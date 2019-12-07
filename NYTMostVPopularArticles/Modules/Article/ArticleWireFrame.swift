//
//  ArticleWireFrame.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/7/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation

class ArticleWireFrame {
    let viewController: ArticleViewController

    init(article: Article) {
        let viewModel = ArticleViewModel(article: article)
        viewController = ArticleViewController.instantiatedView()
        viewController.viewModel = viewModel
    }
}
