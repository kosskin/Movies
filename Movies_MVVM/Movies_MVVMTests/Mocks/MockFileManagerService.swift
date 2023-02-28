// MockFileManagerService.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation
@testable import Movies_MVVM

/// Mock file manager service
final class MockFileManagerService: FileManagerServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let mockUrl = "house"
        static let mockNumber = 0
    }

    // MARK: - Private Properties

    private let mockData = Data(count: Constants.mockNumber)

    // MARK: - Public Methods

    func saveImageToCache(url: String, data: Data) {
        FileManager.default.createFile(atPath: Constants.mockUrl, contents: mockData)
    }

    func getImageFromCache(url: String) -> Data? {
        mockData
    }
}
