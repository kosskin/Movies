// CoreDataServiceProtocol.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Protocol for Core data service
protocol CoreDataServiceProtocol {
    func saveContext(movies: [Movie], movieType: String)
    func getData(type: String) -> [MovieData]
    func saveDetailContext(movie: Movie)
    func getDetailData(movieId: Int) -> [MovieData]
}
