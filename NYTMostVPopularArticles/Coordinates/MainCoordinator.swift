//
//  MainCoordinator.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/7/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MostPopularWireFrame().viewController
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func routeToArticleDetails(article: Article) {
        let articleModule = ArticleWireFrame(article: article)
        let viewController = articleModule.viewController
        navigationController.pushViewController(viewController, animated: true)
    }
}
