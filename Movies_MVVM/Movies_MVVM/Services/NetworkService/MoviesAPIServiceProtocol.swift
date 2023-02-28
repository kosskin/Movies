// MoviesAPIServiceProtocol.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Protocol for service for working with requests
protocol MoviesAPIServiceProtocol {
    var apiKey: String? { get set }

    func sendRequest(category: String, completion: @escaping (Result<MoviesList, Error>) -> Void)
    func sendRequest(id: String, completion: @escaping (Result<Movie, Error>) -> Void)
}
