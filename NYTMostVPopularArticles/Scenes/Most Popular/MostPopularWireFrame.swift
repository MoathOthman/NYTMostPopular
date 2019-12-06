//
//  MostPopularWireFrame.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/5/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation

class MostPopularWireFrame {
    let viewController: MostPopularViewController

    init() {
        let api = NYTAPIClient()
        let viewModel = MostPopularViewModel(api: api)
        self.viewController = MostPopularViewController(nibName: "MostPopularViewController", bundle: nil)
        self.viewController.viewModel = viewModel
    }
}
