// FileManagerServiceProtocol.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Protocol for FileManagerService
protocol FileManagerServiceProtocol {
    func saveImageToCache(url: String, data: Data)
    func getImageFromCache(url: String) -> Data?
}
