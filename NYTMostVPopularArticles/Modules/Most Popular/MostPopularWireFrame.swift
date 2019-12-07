//
//  MostPopularWireFrame.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/5/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class MostPopularWireFrame {
    let viewController: MostPopularViewController
    let bag = DisposeBag()

    init() {
        let api = NYTAPIClient()
        let model = MostPopularModelLayer(api: api)
        let viewModel = MostPopularViewModel(model: model)
        self.viewController = MostPopularViewController.instantiatedView()
        self.viewController.viewModel = viewModel
    }
}
