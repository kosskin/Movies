// SearchFilmViewModelProtocol.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Protocol for Search film view model
protocol SearchFilmViewModelProtocol {
    var movies: [MovieData]? { get }
    var searchFilmStates: StateHandler? { get set }
    var showErrorAlert: ErrorHandler? { get set }
    var uploadApiKeyCompletion: VoidHandler? { get set }

    func fetchMovies(category: String)
    func sortingByCategory(tag: Int)
    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
    func uploadApiKey(_ value: String)
    func checkApiKey()
    func loadMovies(category: String)
}
