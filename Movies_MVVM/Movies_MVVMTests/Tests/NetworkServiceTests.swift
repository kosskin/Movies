// NetworkServiceTests.swift
// Copyright © Koskin VA. All rights reserved.

@testable import Movies_MVVM
import XCTest

/// Tests for network service
final class NetworkServiceTests: XCTestCase {
    // MARK: - Constants

    private enum Constants {
        static let mockCategory = "popular"
        static let mockMovieId = 297_761
    }

    // MARK: - Private Properties

    private var networkService: NetworkServiceProtocol?
    private var mockMoviesAPIService = MockMoviesAPIService()

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        networkService = NetworkService(moviesAPIService: mockMoviesAPIService)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        networkService = nil
    }

    func testFetchMovies() {
        networkService?.fetchMovies(category: Constants.mockCategory, completion: { result in
            switch result {
            case let .success(data):
                XCTAssertNotEqual(data.count, 0)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }

    func testFetchMovieInfo() {
        networkService?.fetchMovieInfo(id: String(Constants.mockMovieId), completion: { result in
            switch result {
            case let .success(movie):
                XCTAssertEqual(movie.movieId, Constants.mockMovieId)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }
}
