// SearchFilmStates.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Types of condition
enum SearchFilmState {
    case initial
    case success
    case failure(Error)
}
