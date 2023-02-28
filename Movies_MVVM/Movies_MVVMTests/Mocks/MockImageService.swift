// MockImageService.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation
@testable import Movies_MVVM

/// Mock image service
final class MockImageService: ImageServiceProtocol {
    // MARK: - Public Methods

    func getPhoto(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.success(Data()))
    }
}
