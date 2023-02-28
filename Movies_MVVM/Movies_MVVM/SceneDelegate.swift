// SceneDelegate.swift
// Copyright © Koskin VA. All rights reserved.

import UIKit

/// Changes first screen
@available(iOS 16.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: Constants

    private enum Constants {
        static let backgoundColorName = "backgroundColor"
        static let textColorName = "textColor"
    }

    // MARK: Public Properties

    var window: UIWindow?

    // MARK: - Private Properties

    private var coordinator: BaseCoordinator?

    // MARK: - Public Methods

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        let assemblyBuilder = AssemblyBuilder()
        coordinator = AppCoordinator(assemblyBuilder: assemblyBuilder)
        coordinator?.start()
    }
}
