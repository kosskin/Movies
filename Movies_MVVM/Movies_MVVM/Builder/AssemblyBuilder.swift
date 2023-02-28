// AssemblyBuilder.swift
// Copyright © Koskin VA. All rights reserved.

import UIKit

/// Builder
@available(iOS 16.0, *)
final class AssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeSearchFilmScreen() -> UIViewController {
        let keyChainService = KeychainService()
        let moviesAPIService = MoviesAPIService()
        let networkService = NetworkService(moviesAPIService: moviesAPIService)
        let imageService = ImageService()
        let searchFilmViewModel = SearchFilmViewModel(
            networkService: networkService,
            imageService: imageService,
            keychainService: keyChainService
        )
        return SearchFilmViewController(searchFilmViewModel: searchFilmViewModel)
    }

    func makeMovieDetailsScreen(movie: MovieData) -> UIViewController {
        let moviesAPIService = MoviesAPIService()
        let imageService = ImageService()
        let networkService = NetworkService(moviesAPIService: moviesAPIService)
        let movieDetailsViewModel = MovieDetailsViewModel(
            networkService: networkService,
            imageService: imageService,
            movie: movie
        )
        return MovieDetailsViewController(movieDetailViewModel: movieDetailsViewModel)
    }
}
