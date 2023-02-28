// MoviesAPIService.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Service for working with requests
final class MoviesAPIService: MoviesAPIServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let baseURL = "https://api.themoviedb.org/3/movie/"
        static let APIKey = "api_key"
        static let languageKey = "language"
        static let languageValue = "ru-RU"
        static let pageKey = "page"
        static let pageValue = "1"
        static let apiKeyKey = "apiKey"
    }

    // MARK: - Public Properties

    var apiKey: String?

    // MARK: - Public Methods

    func sendRequest(category: String, completion: @escaping (Result<MoviesList, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: "\(URLRequest.baseURL)\(category)") else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.APIKey, value: apiKey),
            URLQueryItem(name: Constants.languageKey, value: Constants.languageValue)
        ]
        guard let url = urlComponents.url else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let movies = try JSONDecoder().decode(MoviesList.self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func sendRequest(id: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        guard let url = URL(string: "\(URLRequest.baseURL)\(id)\(URLRequest.apiKey)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(movie))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
