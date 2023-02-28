// KeychainServiceProtocol.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Protocol for Keychain service
protocol KeychainServiceProtocol {
    func save(_ value: String, _ key: String)
    func get(_ key: String) -> String?
}
