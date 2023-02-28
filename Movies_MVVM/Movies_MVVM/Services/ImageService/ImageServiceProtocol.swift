// ImageServiceProtocol.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Protocol for Image service
protocol ImageServiceProtocol {
    func getPhoto(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
