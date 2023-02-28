// CoreDataServiceTests.swift
// Copyright © Koskin VA. All rights reserved.

@testable import Movies_MVVM
import XCTest

/// Tests for core data service
final class CoreDataServiceTests: XCTestCase {
    // MARK: - Constants

    private enum Constants {
        static let mockModelName = "model"
        static let mockMovieId = 297_761
        static let mockString = ""
        static let mockIntNum = 1
        static let mockDoubleNum = 1.0
    }

    // MARK: - Private Properties

    private let mockMovies = [Movie(
        movieId: Constants.mockIntNum,
        overview: Constants.mockString,
        raiting: Constants.mockDoubleNum,
        title: Constants.mockString,
        image: Constants.mockString,
        realeaseDate: Constants.mockString
    )]
    private let mockMovie = Movie(
        movieId: Constants.mockMovieId,
        overview: Constants.mockString,
        raiting: Constants.mockDoubleNum,
        title: Constants.mockString,
        image: Constants.mockString,
        realeaseDate: Constants.mockString
    )
    private var coreDataService: CoreDataServiceProtocol?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        coreDataService = CoreDataService(modelName: Constants.mockModelName)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        coreDataService = nil
    }

    func testGetData() {
        coreDataService?.getData(type: URLRequest.popular)
    }

    func testGetDetailData() {
        coreDataService?.getDetailData(movieId: Constants.mockMovieId)
    }
}
