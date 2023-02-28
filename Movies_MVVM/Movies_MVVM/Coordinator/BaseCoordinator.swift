// BaseCoordinator.swift
// Copyright © Koskin VA. All rights reserved.

import UIKit

/// Abstract coordinator
@available(iOS 16.0, *)
class BaseCoordinator {
    // MARK: - Private Properties

    private var childCoordinators: [BaseCoordinator] = []

    // MARK: - Public Methods

    func start() {}

    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: BaseCoordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else { return }
        for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func setAsRoot(_ controller: UIViewController) {
        let sceneDelegate =
            UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = controller
    }
}
