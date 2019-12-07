//
//  MostPopularViewController.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/5/19.
//  Copyright © 2019 moath. All rights reserved.
//

import RxSwift
import Toast_Swift
import UIKit

class MostPopularViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel: MostPopularViewModelProtocol! {
        didSet {
            bind()
            refresh()
        }
    }
    var tableView = UITableView()
    let bag = DisposeBag()
    weak var coordinator: MainCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Articles"
        tableView.delegate = self
        tableView.dataSource = self
        layoutTableView()
        setupCell()

        // Styling
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func bind() {
        viewModel.loading
            .observeOn(MainScheduler())
            .bind(onNext: startLoader)
            .disposed(by: bag)
    }

    private func startLoader(_ loading: Bool) {
        if loading {
            view.makeToastActivity(.center)
        } else {
            view.hideToastActivity()
            tableView.reloadData()
        }
    }

    private func layoutTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    func setupCell() {
        let nib = UINib(nibName: cellNib, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }

    var cellNib: String {
        return "MostPopularTableViewCell"
    }

    var reuseIdentifier: String {
        return "mostpopular"
    }

    private func refresh() {
        viewModel.fetchData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRows(forSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = configurableCell()
        let cellViewmodel = viewModel.cellViewModel(forIndex: indexPath)
        cell.configure(viewModel: cellViewmodel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator.routeToArticleDetails(article: viewModel.article(forIndex: indexPath))
    }
    //swiftlint:disable force_cast
    private func configurableCell() -> MostPopularTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MostPopularTableViewCell
    }
    //swiftlint:enable force_cast
}

extension MostPopularViewController: StoryBoardable {
    typealias ViewControllerType = MostPopularViewController

    static func storyBoardInstance() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
