// MovieDetailsViewModel.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Movie detail view model
final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    // MARK: - Public Properties

    var movie: MovieData?
    var updateView: VoidHandler?
    var showErrorAlert: ErrorHandler?

    // MARK: - Private Properties

    private let networkService: NetworkServiceProtocol
    private let imageService: ImageServiceProtocol
    private let coreDataStack = CoreDataService(modelName: "Movies_MVVMCoreData")

    // MARK: - Initializers

    required init(networkService: NetworkServiceProtocol, imageService: ImageServiceProtocol, movie: MovieData) {
        self.imageService = imageService
        self.networkService = networkService
        self.movie = movie
    }

    // MARK: - Public Methods

    func fetchMovieInfo() {
        guard let movieId = movie?.movieId else { return }
        networkService.fetchMovieInfo(id: String(movieId)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movie):
                self.movie = self.coreDataStack.getDetailData(movieId: Int(movie.movieId ?? 0)).first
                self.coreDataStack.saveDetailContext(movie: movie)
            case let .failure(error):
                self.showErrorAlert?(error)
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
}
