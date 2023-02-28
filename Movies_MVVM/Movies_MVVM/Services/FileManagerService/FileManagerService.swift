// FileManagerService.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// File Manager Service
@available(iOS 16.0, *)
final class FileManagerService: FileManagerServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let folderName = "Images"
        static let separator = "/"
        static let defaultString: Substring = "default"
        static let defaultImageName = "photo"
    }

    // MARK: - Public Methods

    func saveImageToCache(url: String, data: Data) {
        guard let filePath = getImagePath(url: url) else { return }
        FileManager.default.createFile(atPath: filePath, contents: data)
    }

    func getImageFromCache(url: String) -> Data? {
        guard let filePath = getImagePath(url: url)
        else { return nil }
        let fileNameURL = URL(filePath: filePath)
        let image = try? Data(contentsOf: fileNameURL)
        return image
    }

    // MARK: - Private Methods

    private func getImagePath(url: String) -> String? {
        guard let folderUrl = getCacheFolderPath() else { return nil }
        let fileName = String(url.split(separator: Constants.separator).last ?? Constants.defaultString)
        return folderUrl.appendingPathComponent(fileName).path
    }

    private func getCacheFolderPath() -> URL? {
        guard let docsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        let url = docsDirectory.appendingPathComponent(Constants.folderName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                print(error)
            }
        }
        return url
    }
}
