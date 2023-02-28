// KeychainService.swift
// Copyright © Koskin VA. All rights reserved.

import KeychainSwift

/// Keychain service
final class KeychainService: KeychainServiceProtocol {
    // MARK: Constants

    private enum Constants {
        static let apiKeyKey = "apiKey"
    }

    // MARK: - Private Properties

    private let keyChain = KeychainSwift()

    // MARK: - Public Methods

    func save(_ value: String, _ key: String) {
        guard keyChain.set(value, forKey: key) else {
            return
        }
    }

    func get(_ key: String) -> String? {
        keyChain.get(key)
    }
}
