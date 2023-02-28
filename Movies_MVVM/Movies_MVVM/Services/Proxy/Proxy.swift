// Proxy.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Proxy
@available(iOS 16.0, *)
final class Proxy: ProxyProtocol {
    // MARK: - Private Properties

    private let imageAPIService: ImageAPIServiceProtocol
    private let fileManagerService: FileManagerServiceProtocol

    // MARK: - Initializers

    init(imageAPIService: ImageAPIServiceProtocol, fileManagerService: FileManagerServiceProtocol) {
        self.imageAPIService = imageAPIService
        self.fileManagerService = fileManagerService
    }

    // MARK: - Public Methods

    func loadImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let image = fileManagerService.getImageFromCache(url: url) else {
            imageAPIService.fetchImage(imageUrl: url) { [weak self] result in
                switch result {
                case let .success(data):
                    self?.fileManagerService.saveImageToCache(url: url, data: data)
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
            return
        }
        completion(.success(image))
    }
}
