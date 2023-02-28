// CoreDataService.swift
// Copyright © Koskin VA. All rights reserved.

import CoreData

/// Data base
final class CoreDataService: CoreDataServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let errorText = "Ошибка:"
        static let coreDataModelName = "MovieData"
        static let predicateFormat = "movieType = %@"
        static let predicateDetailFormat = "movieId = %i"
        static let alertTitle = "Ошибка"
        static let alertActionTitle = "OK"
    }

    // MARK: - Private Properties

    private let modelName: String
    private lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("\(Constants.errorText) \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Initializers

    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Public Methods

    func saveContext(movies: [Movie], movieType: String) {
        guard let newMovie = NSEntityDescription.entity(
            forEntityName: Constants.coreDataModelName,
            in: managedContext
        ) else { return }
        for movie in movies {
            let newMovie = MovieData(entity: newMovie, insertInto: managedContext)
            newMovie.title = movie.title
            newMovie.image = movie.image
            newMovie.overview = movie.overview
            newMovie.movieId = Int64(movie.movieId ?? 0)
            newMovie.raiting = Double(movie.raiting ?? 0.0)
            newMovie.realeaseDate = movie.realeaseDate
            newMovie.movieType = movieType
            newMovie.id = UUID()
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("\(Constants.errorText) \(error), \(error.userInfo)")
            }
        }
    }

    func getData(type: String) -> [MovieData] {
        var movieObjects: [MovieData] = []
        let fetchRequest: NSFetchRequest<MovieData> = MovieData.fetchRequest()
        let predicate = NSPredicate(format: Constants.predicateFormat, type)
        fetchRequest.predicate = predicate
        do {
            movieObjects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return movieObjects
    }

    func saveDetailContext(movie: Movie) {
        guard let newMovie = NSEntityDescription.entity(
            forEntityName: Constants.coreDataModelName,
            in: managedContext
        ) else { return }
        let newMovieData = MovieData(entity: newMovie, insertInto: managedContext)
        newMovieData.title = movie.title
        newMovieData.image = movie.image
        newMovieData.overview = movie.overview
        newMovieData.movieId = Int64(movie.movieId ?? 0)
        newMovieData.raiting = Double(movie.raiting ?? 0.0)
        newMovieData.realeaseDate = movie.realeaseDate
        newMovieData.id = UUID()
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(Constants.errorText) \(error), \(error.userInfo)")
        }
    }

    func getDetailData(movieId: Int) -> [MovieData] {
        var movieObjects: [MovieData] = []
        let fetchRequest: NSFetchRequest<MovieData> = MovieData.fetchRequest()
        let predicate = NSPredicate(format: Constants.predicateDetailFormat, movieId)
        fetchRequest.predicate = predicate
        do {
            movieObjects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return movieObjects
    }
}
