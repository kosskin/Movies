// ImageAPIServiceProtocol.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Protocol for ImageAPIService
protocol ImageAPIServiceProtocol {
    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void)
}
