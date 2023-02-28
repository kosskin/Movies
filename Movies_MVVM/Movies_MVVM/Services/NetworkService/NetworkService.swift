// NetworkService.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Service for working with API
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Public Properties

    private var moviesAPIService: MoviesAPIServiceProtocol

    // MARK: - Initializers

    init(moviesAPIService: MoviesAPIServiceProtocol) {
        self.moviesAPIService = moviesAPIService
    }

    // MARK: - Public Methods

    func fetchMovies(category: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        moviesAPIService.sendRequest(category: category) { result in
            switch result {
            case let .success(data):
                let movies = data.movies
                completion(.success(movies))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchMovieInfo(id: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        moviesAPIService.sendRequest(id: id) { result in
            switch result {
            case let .success(movie):
                completion(.success(movie))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func setupAPIKey(_ apiKey: String) {
        moviesAPIService.apiKey = apiKey
    }
}
