// ImageService.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Service for cache image
@available(iOS 16.0, *)
final class ImageService: ImageServiceProtocol {
    // MARK: - Private Properties

    private let imageAPIService = ImageAPIService()
    private let fileManagerService = FileManagerService()

    // MARK: - Public Methods

    func getPhoto(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let proxy = Proxy(imageAPIService: imageAPIService, fileManagerService: fileManagerService)
        proxy.loadImage(url: url) { result in
            switch result {
            case let .success(image):
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
