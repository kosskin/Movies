// Movies_MVVMUITests.swift
// Copyright © Koskin VA. All rights reserved.

import XCTest

/// UI tests
final class Movies_MVVMUITests: XCTestCase {
    // MARK: - Constants

    private enum Constants {
        static let numberZero = "0"
        static let sevenDotFive = "7.5"
        static let topRaiting = "Топ рейтинга"
        static let premiers = "Премьеры"
        static let populars = "Популярные"
        static let back = "Back"
        static let movieDetailsView = "Movies_MVVM.MovieDetailsView"
        static let searchTableViewId = "searchTableView"
    }

    // MARK: - Private Properties

    private let app = XCUIApplication()

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    func testExample() throws {
        app.launch()
        let tableView = app.tables.matching(identifier: Constants.searchTableViewId)
        XCTAssertNotNil(tableView)
        tableView.cells.firstMatch.staticTexts[Constants.sevenDotFive].tap()
        app.navigationBars[Constants.movieDetailsView].buttons[Constants.back].tap()
        app.staticTexts[Constants.premiers].tap()
        app.staticTexts[Constants.topRaiting].tap()
        app.staticTexts[Constants.populars].tap()
        app.swipeUp()
        app.swipeDown()
    }
}
