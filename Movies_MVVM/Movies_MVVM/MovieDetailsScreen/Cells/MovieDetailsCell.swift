// MovieDetailsCell.swift
// Copyright © Koskin VA. All rights reserved.

import UIKit

/// Cell with full information about film
@available(iOS 16.0, *)
final class MovieDetailsCell: UITableViewCell {
    // MARK: Constants

    private enum Constants {
        static let backgoundColorName = "backgroundColor"
        static let textColorName = "textColor"
        static let startUrlText = "https://image.tmdb.org/t/p/w300"
        static let dateRealeseText = "Дата выхода фильма: "
        static let raitingText = "Рейтинг фильма: "
    }

    // MARK: Visual Components

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let movieOverviewTextview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(named: Constants.textColorName)
        return label
    }()

    private let moreDetailTextView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(named: Constants.textColorName)
        return label
    }()

    // MARK: - Public Properties

    weak var alertDelegate: AlertDelegate?

    // MARK: Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    func configure(movie: MovieData, movieDetailsViewModel: MovieDetailsViewModelProtocol) {
        let raiting = movie.raiting
        guard let releaseDate = movie.realeaseDate else { return }
        moreDetailTextView.text = """
        \(Constants.dateRealeseText) \(releaseDate)
        \(Constants.raitingText) \(raiting)
        """
        guard let overview = movie.overview else { return }
        movieOverviewTextview.text = overview
        guard let imageName = movie.image else { return }
        let url = Constants.startUrlText + imageName
        fetchImage(url: url, movieDetailsViewModel: movieDetailsViewModel)
    }

    // MARK: Private Methods

    private func fetchImage(url: String, movieDetailsViewModel: MovieDetailsViewModelProtocol) {
        movieDetailsViewModel.fetchImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                DispatchQueue.main.async {
                    self.movieImageView.image = UIImage(data: data)
                }
            case let .failure(error):
                self.alertDelegate?.showAlert(error: error)
            }
        }
    }

    private func configUI() {
        backgroundColor = UIColor(named: Constants.backgoundColorName)
        addSubview(movieImageView)
        addSubview(movieOverviewTextview)
        addSubview(moreDetailTextView)
        setupAllConstraints()
    }

    private func setupAllConstraints() {
        setMovieImageViewConstraints()
        setMovieOverviewTextViewConstraints()
        setMoreDetailTextViewConstraints()
    }

    private func setMovieImageViewConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            movieImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            movieImageView.widthAnchor.constraint(equalTo: widthAnchor),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 1.2)
        ])
    }

    private func setMovieOverviewTextViewConstraints() {
        NSLayoutConstraint.activate([
            movieOverviewTextview.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 5),
            movieOverviewTextview.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieOverviewTextview.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            movieOverviewTextview.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }

    private func setMoreDetailTextViewConstraints() {
        NSLayoutConstraint.activate([
            moreDetailTextView.topAnchor.constraint(equalTo: movieOverviewTextview.bottomAnchor, constant: 5),
            moreDetailTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            moreDetailTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            moreDetailTextView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
