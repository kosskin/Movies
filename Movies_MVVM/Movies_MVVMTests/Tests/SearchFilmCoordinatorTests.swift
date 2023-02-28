// SearchFilmCoordinatorTests.swift
// Copyright © Koskin VA. All rights reserved.

@testable import Movies_MVVM
import XCTest

/// Tests search film coordinator
final class SearchFilmCoordinatorTests: XCTestCase {
    // MARK: - Private Properties

    private let mockAssemblyBuilder = MockAssemblyBuilder()
    private var searchFilmCoordinator: BaseCoordinator?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        searchFilmCoordinator = SearchFilmCoordinator(assemblyBuilder: mockAssemblyBuilder)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        searchFilmCoordinator = nil
    }

    func testShowSearchFilmModule() {
        searchFilmCoordinator?.start()
    }
}
