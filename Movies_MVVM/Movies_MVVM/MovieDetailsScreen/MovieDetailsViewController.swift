// MovieDetailsViewController.swift
// Copyright © Koskin VA. All rights reserved.

import UIKit

/// Screen with film details
@available(iOS 16.0, *)
final class MovieDetailsViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let movieDetailsCellName = "movieDetailsCell"
        static let backgoundColorName = "backgroundColor"
        static let textColorName = "textColor"
        static let startUrlText = "https://image.tmdb.org/t/p/w300"
        static let favoriteText = "Вы добавили фильм в избранное"
        static let okText = "Ok"
        static let unknownErrorText = "unknown error"
        static let urlErrorText = "url error"
        static let decodingText = "decoding error"
        static let errorTitle = "Error"
        static let actionTitle = "Ok"
    }

    // MARK: Visual Components

    private let movieDetailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieDetailsCell.self, forCellReuseIdentifier: Constants.movieDetailsCellName)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: Private Properties

    private var movieDetailViewModel: MovieDetailsViewModelProtocol

    // MARK: - Initializers

    init(movieDetailViewModel: MovieDetailsViewModelProtocol) {
        self.movieDetailViewModel = movieDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    // MARK: Private Methods

    private func configUI() {
        view.backgroundColor = UIColor(named: Constants.backgoundColorName)
        setNavigationBar()
        movieDetailsTableView.dataSource = self
        view.addSubview(movieDetailsTableView)
        setConstraintsTableView()
        updateView()
        showErrorAlert()
        movieDetailViewModel.fetchMovieInfo()
    }

    private func updateView() {
        movieDetailViewModel.updateView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.movieDetailsTableView.reloadData()
            }
        }
    }

    private func setNavigationBar() {
        navigationController?.navigationBar.tintColor = .orange
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(getAlertAction(sender:))
        )
    }

    private func setConstraintsTableView() {
        NSLayoutConstraint.activate([
            movieDetailsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieDetailsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieDetailsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func showErrorAlert() {
        movieDetailViewModel.showErrorAlert = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert(error: error)
            }
        }
    }

    @objc func getAlertAction(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: Constants.favoriteText, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Constants.okText, style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource

@available(iOS 16.0, *)
extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.movieDetailsCellName,
            for: indexPath
        ) as? MovieDetailsCell
        else { return UITableViewCell() }
        guard let currentMovieDetail = movieDetailViewModel.movie else { return UITableViewCell() }
        cell.configure(movie: currentMovieDetail, movieDetailsViewModel: movieDetailViewModel)
        cell.alertDelegate = self
        return cell
    }
}

/// Alert delegate protocol
@available(iOS 16.0, *)
extension MovieDetailsViewController: AlertDelegate {
    func showAlert(error: Error) {
        showAlert(
            title: Constants.errorTitle,
            message: error.localizedDescription,
            actionTitle: Constants.actionTitle,
            handler: nil
        )
    }
}
