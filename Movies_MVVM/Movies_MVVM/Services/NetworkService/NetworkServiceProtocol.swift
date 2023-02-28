// NetworkServiceProtocol.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Protocol to NetworkService
protocol NetworkServiceProtocol {
    func fetchMovies(category: String, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovieInfo(id: String, completion: @escaping (Result<Movie, Error>) -> Void)
    func setupAPIKey(_ apiKey: String)
}
