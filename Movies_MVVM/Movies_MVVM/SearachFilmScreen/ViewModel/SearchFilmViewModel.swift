// SearchFilmViewModel.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Search film view model
final class SearchFilmViewModel: SearchFilmViewModelProtocol {
    // MARK: - Constants

    private enum Constants {
        static let apiKey = "apiKey"
    }

    // MARK: - Public Properties

    var movies: [MovieData]?
    var searchFilmStates: StateHandler?
    var showErrorAlert: ErrorHandler?
    var uploadApiKeyCompletion: VoidHandler?
    var coreDataStack = CoreDataService(modelName: "Movies_MVVMCoreData")

    // MARK: - Private Properties

    private let networkService: NetworkServiceProtocol
    private let imageService: ImageServiceProtocol
    private let keychainService: KeychainServiceProtocol

    // MARK: - Initializers

    required init(
        networkService: NetworkServiceProtocol,
        imageService: ImageServiceProtocol,
        keychainService: KeychainServiceProtocol
    ) {
        self.imageService = imageService
        self.networkService = networkService
        self.keychainService = keychainService
    }

    // MARK: - Public Methods

    func fetchMovies(category: String) {
        networkService.fetchMovies(category: category) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.coreDataStack.saveContext(movies: movies, movieType: category)
                self.movies = self.coreDataStack.getData(type: category)
                self.searchFilmStates?(.success)
            case let .failure(error):
                self.searchFilmStates?(.failure(error))
            }
        }
    }

    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        imageService.getPhoto(url: url) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func sortingByCategory(tag: Int) {
        switch tag {
        case 0:
            loadMovies(category: URLRequest.popular)
        case 1:
            loadMovies(category: URLRequest.topMovies)
        case 2:
            loadMovies(category: URLRequest.upcoming)
        default:
            break
        }
    }

    func loadMovies(category: String) {
        let movies = coreDataStack.getData(type: category)
        if !movies.isEmpty {
            self.movies = movies
            searchFilmStates?(.success)
        } else {
            fetchMovies(category: category)
        }
    }

    func checkApiKey() {
        // swiftlint:disable all
        guard let apiKey = keychainService.get(Constants.apiKey), keychainService.get(Constants.apiKey) != "" else {
            // swiftlint:enable all
            uploadApiKeyCompletion?()
            return
        }
        networkService.setupAPIKey(apiKey)
    }

    func uploadApiKey(_ value: String) {
        keychainService.save(value, Constants.apiKey)
        networkService.setupAPIKey(value)
    }
}
