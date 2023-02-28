// ImageAPIService.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Service for fetch image
final class ImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Public Methods

    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = URL(string: "\(URLRequest.baseImageURL)\(imageUrl)") else { return }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard response is HTTPURLResponse else {
                return
            }
            guard let data = data else {
                return
            }
            completion(.success(data))
        }.resume()
    }
}
