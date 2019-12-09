//
//  ArticleViewController.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/7/19.
//  Copyright © 2019 moath. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ArticleViewController: UIViewController {

    var viewModel: ArticleViewModel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var publishedBy: UILabel!
    @IBOutlet private var publishedOn: UILabel!
    @IBOutlet private var viewsNumber: UILabel!
    @IBOutlet private var sourceLabel: UILabel!
    @IBOutlet private var abstractLabel: UILabel!

    let bag = DisposeBag()
    private var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel
            .article
            .observeOn(MainScheduler())
            .subscribe(onNext: { article in
                self.titleLabel.text = article.title
                self.publishedBy.text = article.byline
                self.publishedOn.text = article.publishedDate
                self.viewsNumber.text = "\(article.views)"
                self.sourceLabel.text = "Sourced by: " + article.source
                self.abstractLabel.text = article.abstractField
                self.url = article.url
                self.title = article.source
            }).disposed(by: bag)
    }
    
    @IBAction private func showArticle(_ sender: Any) {
        guard let urlString = self.url, let url = URL(string: urlString) else {
            view.makeToast("Article is not available")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension ArticleViewController: StoryBoardable {
    typealias ViewControllerType = ArticleViewController

    static func storyBoardInstance() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
