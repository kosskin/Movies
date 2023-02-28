// ProxyProtocol.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Protocol for Proxy
protocol ProxyProtocol {
    func loadImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
