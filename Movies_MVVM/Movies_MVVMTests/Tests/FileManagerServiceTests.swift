// FileManagerServiceTests.swift
// Copyright © Koskin VA. All rights reserved.

@testable import Movies_MVVM
import XCTest

/// Tests for file manager service
final class FileManagerServiceTests: XCTestCase {
    // MARK: - Constants

    private enum Constants {
        static let mockHomeName = "house"
        static let mockNumber = 1
    }

    // MARK: - Private Properties

    private var fileManagerService: FileManagerServiceProtocol?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        fileManagerService = FileManagerService()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        fileManagerService = nil
    }

    func testFileManagerService() {
        let mockData = Data(count: Constants.mockNumber)
        fileManagerService?.saveImageToCache(url: Constants.mockHomeName, data: mockData)
        let data = fileManagerService?.getImageFromCache(url: Constants.mockHomeName)
        XCTAssertEqual(data, mockData)
    }
}
