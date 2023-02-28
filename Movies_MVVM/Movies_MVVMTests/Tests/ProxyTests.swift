// ProxyTests.swift
// Copyright © Koskin VA. All rights reserved.

@testable import Movies_MVVM
import XCTest

/// Tests for proxy service
final class ProxyTests: XCTestCase {
    // MARK: - Constants

    private enum Constants {
        static let mockUrl = "house"
    }

    // MARK: - Private Properties

    private var proxyService: ProxyProtocol?
    private var mockImageAPIService = MockImageAPIService()
    private var mockFileManagerService = MockFileManagerService()

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        proxyService = Proxy(imageAPIService: mockImageAPIService, fileManagerService: mockFileManagerService)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        proxyService = nil
    }

    func testLoadImage() {
        proxyService?.loadImage(url: Constants.mockUrl, completion: { result in
            switch result {
            case let .success(data):
                XCTAssertNotNil(data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }
}
