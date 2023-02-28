// AssemblyBuilderProtocol.swift
// Copyright © Koskin VA. All rights reserved.

import UIKit

/// Protocol for Assembly builder
protocol AssemblyBuilderProtocol {
    func makeSearchFilmScreen() -> UIViewController
    func makeMovieDetailsScreen(movie: MovieData) -> UIViewController
}
