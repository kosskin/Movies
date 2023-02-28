// MockKeychainService.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation
@testable import Movies_MVVM

/// Mock keychain service
final class MockKeychainService: KeychainServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let mockValue = "mock"
    }

    // MARK: - Private Properties

    private var value: String?

    // MARK: - Public Methods

    func save(_ value: String, _ key: String) {
        self.value = value
    }

    func get(_ key: String) -> String? {
        Constants.mockValue
    }
}
