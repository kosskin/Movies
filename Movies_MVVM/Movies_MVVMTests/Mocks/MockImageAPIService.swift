// MockImageAPIService.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation
@testable import Movies_MVVM

/// Mock image api service
final class MockImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let mockImageUrl = "house"
        static let mockNumber = 0
    }

    // MARK: - Private Properties

    private var mockData = Data(count: Constants.mockNumber)

    // MARK: - Public Methods

    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.success(mockData))
    }
}
