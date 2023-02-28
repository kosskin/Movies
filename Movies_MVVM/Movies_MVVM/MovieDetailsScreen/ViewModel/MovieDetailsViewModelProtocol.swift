// MovieDetailsViewModelProtocol.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Protocol for Movie details view model
protocol MovieDetailsViewModelProtocol {
    // MARK: - Public Properties

    var movie: MovieData? { get }
    var updateView: VoidHandler? { get set }
    var showErrorAlert: ErrorHandler? { get set }

    // MARK: - Public Methods

    func fetchMovieInfo()
    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
