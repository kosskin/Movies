// ImageAPIServiceTests.swift
// Copyright © Koskin VA. All rights reserved.

@testable import Movies_MVVM
import XCTest

/// Tests image API service
final class ImageAPIServiceTests: XCTestCase {
    // MARK: - Constants

    private enum Constants {
        static let mockPathName = "house"
    }

    // MARK: - Private Properties

    private var imageAPIService: ImageAPIServiceProtocol?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        imageAPIService = ImageAPIService()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        imageAPIService = nil
    }

    func testFetchImage() {
        imageAPIService?.fetchImage(imageUrl: Constants.mockPathName, completion: { result in
            switch result {
            case let .success(mockData):
                XCTAssertNotNil(mockData)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }
}
