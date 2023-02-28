// AppCoordinator.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Coodrinator for start app
@available(iOS 16.0, *)
final class AppCoordinator: BaseCoordinator {
    // MARK: Private Properties

    private var assemblyBuilder: AssemblyBuilderProtocol?

    // MARK: - Initializers

    init(assemblyBuilder: AssemblyBuilderProtocol? = nil) {
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Public Methods

    override func start() {
        guard let assemblyBuilder = assemblyBuilder else { return }
        toSearchFilm(assemblyBilder: assemblyBuilder)
    }

    // MARK: - Private Methods

    private func toSearchFilm(assemblyBilder: AssemblyBuilderProtocol) {
        let coordinator = SearchFilmCoordinator(assemblyBuilder: assemblyBilder)
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
