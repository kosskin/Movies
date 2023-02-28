// MoviesAPIServiceTests.swift
// Copyright © Koskin VA. All rights reserved.

@testable import Movies_MVVM
import XCTest

/// Tests Movie API service
final class MoviesAPIServiceTests: XCTestCase {
    // MARK: - Constants

    private enum Constants {
        static let mockMovieName = "MockMovie"
        static let mockMovieExtension = "json"
        static let mockCategory = "popular"
        static let mockMovieId = 297_761
    }

    // MARK: - Private Properties

    private var moviesAPIService: MoviesAPIServiceProtocol?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        moviesAPIService = MoviesAPIService()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        moviesAPIService = nil
    }

    func testSendRequest() {
        moviesAPIService?.sendRequest(category: Constants.mockCategory, completion: { result in
            switch result {
            case let .success(movieList):
                XCTAssertNotEqual(movieList.movies.count, 0)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }

    func testSendRequestForId() {
        moviesAPIService?.sendRequest(id: String(Constants.mockMovieId), completion: { result in
            switch result {
            case let .success(movie):
                XCTAssertNotNil(movie.movieId)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }
}
