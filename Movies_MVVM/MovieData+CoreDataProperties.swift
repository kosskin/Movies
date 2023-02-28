// MovieData+CoreDataProperties.swift
// Copyright © Koskin VA. All rights reserved.

import CoreData
import Foundation

extension MovieData: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieData> {
        NSFetchRequest<MovieData>(entityName: "MovieData")
    }

    /// Id movie in API
    @NSManaged public var movieId: Int64
    /// Overview
    @NSManaged public var overview: String?
    /// Rating
    @NSManaged public var raiting: Double
    /// Title
    @NSManaged public var title: String?
    /// Image url
    @NSManaged public var image: String?
    /// Date of release
    @NSManaged public var realeaseDate: String?
    /// Universal ID
    @NSManaged public var id: UUID?
    /// Movie category type
    @NSManaged public var movieType: String?
}
