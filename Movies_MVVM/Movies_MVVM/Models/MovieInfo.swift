// MovieInfo.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Model for get movies array from server
struct MoviesList: Decodable {
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

/// Model describe one movie in API
struct Movie: Decodable {
    /// Id movie in API
    let movieId: Int?
    /// Overview
    let overview: String?
    /// Rating
    let raiting: Double?
    /// Title
    let title: String?
    /// Image url
    let image: String?
    /// Date of release
    let realeaseDate: String?

    enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case overview
        case raiting = "vote_average"
        case title
        case image = "poster_path"
        case realeaseDate = "release_date"
    }
}
