// URLRequest.swift
// Copyright © Koskin VA. All rights reserved.

import Foundation

/// Constants for URL requests
enum URLRequest {
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "?api_key=74448ef651b5d6b0af58f8899305190d&language=en-US"
    static let popular = "popular"
    static let topMovies = "top_rated"
    static let upcoming = "upcoming"
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
}
