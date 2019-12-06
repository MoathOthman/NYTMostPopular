//
//  MostPopularViewController.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/5/19.
//  Copyright © 2019 moath. All rights reserved.
//

import UIKit

class MostPopularViewController: UIViewController {

    var viewModel: MostPopularViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchData()
    }
}
