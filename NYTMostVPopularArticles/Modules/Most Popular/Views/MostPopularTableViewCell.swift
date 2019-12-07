//
//  MostPopularTableViewCell.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/6/19.
//  Copyright © 2019 moath. All rights reserved.
//

import UIKit

class MostPopularTableViewCell: UITableViewCell {
    @IBOutlet private var title: UILabel!
    @IBOutlet private var publishedBy: UILabel!
    @IBOutlet private var publishedOn: UILabel!
    @IBOutlet private var viewsNumber: UILabel!

    func configure(viewModel: MostPopularCellViewModel) {
        title.text = viewModel.title
        publishedBy.text = viewModel.publishedBy
        publishedOn.text = viewModel.publishedOn
        viewsNumber.text = "\(viewModel.viewsNumber)"
    }
}
