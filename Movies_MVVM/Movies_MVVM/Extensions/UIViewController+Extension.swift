// UIViewController+Extension.swift
// Copyright © Koskin VA. All rights reserved.

import UIKit

/// Typealias
typealias ErrorHandler = (Error) -> (Void)
typealias StateHandler = (SearchFilmState) -> ()
typealias MovieHandler = (MovieData) -> ()
// swiftlint:disable all
typealias VoidHandler = () -> ()
typealias StringHandler = (String) -> ()
// swiftlint:enable all

/// Universal alert for UIViewController
extension UIViewController {
    func showAlert(
        title: String?,
        message: String?,
        actionTitle: String?,
        handler: ((UIAlertAction) -> ())?
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertControllerAction = UIAlertAction(
            title: actionTitle,
            style: .default,
            handler: handler
        )
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }
}

/// Apikey alert for UIVIewController
extension UIViewController {
    func showApiKeyAlert(
        title: String?,
        message: String?,
        actionTitle: String?,
        handler: StringHandler?
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(
            title: actionTitle,
            style: .default
        ) { _ in
            guard let key = alertController.textFields?.first?.text else { return }
            handler?(key)
        }
        alertController.addTextField()
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
