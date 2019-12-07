//
//  ArticleViewModel.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/7/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ArticleViewModel {

    let article: BehaviorRelay<Article>

    init(article: Article) {
        self.article = BehaviorRelay(value: article)
    }
}
