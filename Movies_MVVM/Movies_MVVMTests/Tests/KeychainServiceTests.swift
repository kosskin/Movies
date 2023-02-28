// KeychainServiceTests.swift
// Copyright © Koskin VA. All rights reserved.

@testable import Movies_MVVM
import XCTest

/// Tests keychain service
final class KeychainServiceTests: XCTestCase {
    // MARK: Constants

    private enum Constants {
        static let mockKey = "key"
        static let mockValue = "value"
    }

    // MARK: - Private Properties

    private var keychainService: KeychainServiceProtocol?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        keychainService = KeychainService()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        keychainService = nil
    }

    func testKeychainService() {
        keychainService?.save(Constants.mockValue, Constants.mockKey)
        let value = keychainService?.get(Constants.mockKey)
        XCTAssertEqual(value, Constants.mockValue)
    }
}
