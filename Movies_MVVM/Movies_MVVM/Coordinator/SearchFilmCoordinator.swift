// SearchFilmCoordinator.swift
// Copyright © Koskin VA. All rights reserved.

import UIKit

/// Coordinator for Search film screen
@available(iOS 16.0, *)
final class SearchFilmCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var onFinishFlow: VoidHandler?

    // MARK: - Private Properties

    private var rootController: UINavigationController?
    private var assemblyBuilder: AssemblyBuilderProtocol?

    // MARK: - Initializers

    init(assemblyBuilder: AssemblyBuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Public Methods

    override func start() {
        showSearchFilmModule()
    }

    // MARK: - Private Methods

    private func showSearchFilmModule() {
        guard let controller = assemblyBuilder?.makeSearchFilmScreen() as? SearchFilmViewController else { return }

        controller.toMovieDetailsModule = { [weak self] movie in
            self?.showMovieDetailsModule(movie: movie)
        }
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }

    private func showMovieDetailsModule(movie: MovieData) {
        guard let controller = assemblyBuilder?.makeMovieDetailsScreen(movie: movie) as? MovieDetailsViewController
        else { return }
        rootController?.pushViewController(controller, animated: true)
    }
}
