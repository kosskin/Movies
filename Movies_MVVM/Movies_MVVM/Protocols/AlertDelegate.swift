// AlertDelegate.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Protocol for universal alert
protocol AlertDelegate: AnyObject {
    func showAlert(error: Error)
}
