// MockMoviesAPIService.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation
@testable import Movies_MVVM

/// Mock MoviesAPIService
final class MockMoviesAPIService: MoviesAPIServiceProtocol {
    // MARK: Constants

    private enum Constants {
        static let mockMovieListName = "MockMovieList"
        static let mockMovieName = "MockMovie"
        static let mockExtension = "json"
    }

    // MARK: - Public Properties

    var apiKey: String?

    // MARK: - Public Methods

    func sendRequest(category: String, completion: @escaping (Result<Movies_MVVM.MoviesList, Error>) -> Void) {
        guard let url = Bundle.main
            .url(forResource: Constants.mockMovieListName, withExtension: Constants.mockExtension) else { return }
        do {
            let data = try Data(contentsOf: url)
            let movies = try JSONDecoder().decode(MoviesList.self, from: data)
            completion(.success(movies))
        } catch {
            completion(.failure(error))
        }
    }

    func sendRequest(id: String, completion: @escaping (Result<Movies_MVVM.Movie, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: Constants.mockMovieName, withExtension: Constants.mockExtension)
        else { return }
        do {
            let data = try Data(contentsOf: url)
            let movie = try JSONDecoder().decode(Movie.self, from: data)
            completion(.success(movie))
        } catch {
            completion(.failure(error))
        }
    }
}
