// MockAssemblyBuilder.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation
@testable import Movies_MVVM
import UIKit

/// Mock assembly builder
final class MockAssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeSearchFilmScreen() -> UIViewController {
        UIViewController()
    }

    func makeMovieDetailsScreen(movie: Movies_MVVM.MovieData) -> UIViewController {
        UIViewController()
    }
}
