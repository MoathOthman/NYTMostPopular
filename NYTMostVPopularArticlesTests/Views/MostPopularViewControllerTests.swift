//
//  MostPopularViewControllerTests.swift
//  NYTMostVPopularArticlesTests
//
//  Created by Moath_Othman on 12/9/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Nimble
@testable import NYTMostVPopularArticles
import RxSwift
import XCTest
//swiftlint:disable force_cast
class MostPopularViewControllerTests: XCTestCase {

    var sut: MostPopularViewController!
    var viewModelMock: MostPopularViewModelMock!
    let tableViewMock = TableViewMock.initializeTableViewMock()
    let index = IndexPath(row: 0, section: 0)
    let bag = DisposeBag()
    var coordinatorMock: MainCoordinatorMock!

    override func setUp() {
        super.setUp()
        viewModelMock = MostPopularViewModelMock()
        coordinatorMock = MainCoordinatorMock(navigationController: UINavigationController())
        sut = MostPopularViewController.instantiatedView()
        _ = sut.view
        sut.viewModel = viewModelMock
        sut.coordinator = coordinatorMock
    }

    func testViewController_shouldTableViewBeNotNil() {
        expect(self.sut.tableView).notTo(beNil())
    }

    func testViewController_shouldViewModelbeNotNil() {
        expect(self.sut.viewModel).notTo(beNil())
    }

    func testViewDidLoad_setTableViewDataSource() {
        expect(self.sut.tableView.dataSource).notTo(beNil())
        expect(self.sut.tableView.dataSource is MostPopularViewController) == true
    }

    func testViewDidLoad_setTableViewDelegate() {
        expect(self.sut.tableView.delegate).notTo(beNil())
        expect(self.sut.tableView.delegate is MostPopularViewController) == true
    }

    func testSettingViewModel_shouldCallFetchData() {
        expect(self.viewModelMock.fetchDataCalled) == true
    }

    func testViewDidLoad_setTitle() {
        expect(self.sut.title) == "Articles"
    }

    func testNumberOfRowsInSection_matchViewModelInputAndResult() {
        let result = sut.tableView(self.sut.tableView, numberOfRowsInSection: 0)
        expect(self.viewModelMock.numbersOfRowsCalled) == true
        expect(self.viewModelMock.numbersOfRows(forSection: 0)) == result
    }

    func testCellForRow_shouldCallViewModelWithIndexAndCellConfigureWithThatModel() {
        sut.tableView = tableViewMock
        let cell = sut.tableView(sut.tableView, cellForRowAt: index) as! MostPopularTableViewCellMock

        expect(self.viewModelMock.cellViewModelForIndexCalled) == true
        expect(self.viewModelMock.indexSpy) == self.index

        let vmCellVM = self.viewModelMock.cellViewModel(forIndex: index)
        expect(cell.viewModel) == vmCellVM
        expect(self.tableViewMock.cellDequeuedWasCalled) == true
    }

    func testTableViewDidSelect_shouldCallRouteToArticleDetailOnTheCoordinator() {
        // when
        sut.tableView(sut.tableView, didSelectRowAt: index)
        // then
        expect(self.coordinatorMock.routeToArticleDetailsCalled) == true
        expect(self.coordinatorMock.articleSpy) == viewModelMock.article(forIndex: index)
        expect(self.viewModelMock.articleForIndexCalled) == true
    }
}
