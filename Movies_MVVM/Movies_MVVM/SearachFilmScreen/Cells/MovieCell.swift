// MovieCell.swift
// Copyright © Koskin VA. All rights reserved.

import UIKit

/// describe one cell with movie and information about movie
@available(iOS 16.0, *)
final class MovieCell: UITableViewCell {
    // MARK: Constants

    private enum Constants {
        static let backgoundColorName = "backgroundColor"
        static let textColorName = "textColor"
        static let startUrlText = "https://image.tmdb.org/t/p/w300"
    }

    // MARK: Visual Components

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()

    private let raitingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .orange
        label.font = UIFont.systemFont(ofSize: 16)
        label.layer.cornerRadius = 14
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.textColor = UIColor(named: Constants.backgoundColorName)
        return label
    }()

    private let overviewFilmTextFiew: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 12)
        textView.textColor = UIColor(named: Constants.textColorName)
        return textView
    }()

    private lazy var nameMovieButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(named: Constants.textColorName), for: .normal)
        button.backgroundColor = .orange
        button.clipsToBounds = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        return button
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

    func configure(movie: MovieData, searchFilmViewModel: SearchFilmViewModelProtocol) {
        nameMovieButton.setTitle(movie.title, for: .normal)
        overviewFilmTextFiew.text = movie.overview
        raitingLabel.text = String(movie.raiting)

        guard let imageName = movie.image else { return }

        let urlString = Constants.startUrlText + imageName
        fetchImage(url: urlString, searchFilmViewModel: searchFilmViewModel)
    }

    // MARK: Private Methods

    private func fetchImage(url: String, searchFilmViewModel: SearchFilmViewModelProtocol) {
        searchFilmViewModel.fetchImage(url: url) { [weak self] result in
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
        movieImageView.addSubview(raitingLabel)
        contentView.addSubview(movieImageView)
        contentView.addSubview(nameMovieButton)
        addSubview(overviewFilmTextFiew)
        setupAllConstraints()
    }

    private func setupAllConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            movieImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 1.3),

            nameMovieButton.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 5),
            nameMovieButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameMovieButton.heightAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 0.2),
            nameMovieButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),

            raitingLabel.rightAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: -5),
            raitingLabel.widthAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 0.22),
            raitingLabel.heightAnchor.constraint(equalTo: raitingLabel.widthAnchor),
            raitingLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -5),

            overviewFilmTextFiew.topAnchor.constraint(equalTo: nameMovieButton.bottomAnchor, constant: 2),
            overviewFilmTextFiew.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            overviewFilmTextFiew.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            overviewFilmTextFiew.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
