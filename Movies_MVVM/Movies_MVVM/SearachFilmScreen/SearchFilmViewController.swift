// SearchFilmViewController.swift
// Copyright © Koskin VA. All rights reserved.

import UIKit

/// Screen with list of films and different categories
@available(iOS 16.0, *)
final class SearchFilmViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let movieCellId = "movieCell"
        static let popularButtonText = "Популярные"
        static let topRatingButtonText = "Топ рейтинга"
        static let upcomingButtonText = "Премьеры"
        static let backgoundColorName = "backgroundColor"
        static let textColorName = "textColor"
        static let startUrlText = "https://image.tmdb.org/t/p/w300"
        static let requestFailedText = "Request failed "
        static let errorTitle = "Error"
        static let actionTitle = "Ok"
        static let apiTitleText = "Ключ API"
        static let apiMessageText = "Введите ключ API"
        static let searchTableViewId = "searchTableView"
    }

    // MARK: Visual Components

    private lazy var popularButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.popularButtonText, for: .normal)
        button.setTitleColor(UIColor(named: Constants.backgoundColorName), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.tag = 0
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(sortingButtonAction(sender:)), for: .touchUpInside)
        return button
    }()

    private lazy var topRatingButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.topRatingButtonText, for: .normal)
        button.setTitleColor(UIColor(named: Constants.backgoundColorName), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.tag = 1
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(sortingButtonAction(sender:)), for: .touchUpInside)
        return button
    }()

    private lazy var upcomingButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.upcomingButtonText, for: .normal)
        button.setTitleColor(UIColor(named: Constants.backgoundColorName), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.tag = 2
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(sortingButtonAction(sender:)), for: .touchUpInside)
        return button
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [popularButton, topRatingButton, upcomingButton])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        return stackView
    }()

    private let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.accessibilityIdentifier = Constants.searchTableViewId
        tableView.register(MovieCell.self, forCellReuseIdentifier: Constants.movieCellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityViewController = UIActivityIndicatorView()
        activityViewController.translatesAutoresizingMaskIntoConstraints = false
        return activityViewController
    }()

    // MARK: - Public Properties

    var toMovieDetailsModule: MovieHandler?

    // MARK: - Private Properties

    private var searchFilmViewModel: SearchFilmViewModelProtocol
    private var searchScreenState: SearchFilmState = .initial {
        didSet {
            DispatchQueue.main.async {
                self.view.setNeedsLayout()
            }
        }
    }

    // MARK: - Initializers

    init(searchFilmViewModel: SearchFilmViewModelProtocol) {
        self.searchFilmViewModel = searchFilmViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        stateChangeActions()
    }

    // MARK: Private Methods

    private func stateChangeActions() {
        switch searchScreenState {
        case .initial:
            configUI()
            activityIndicator.startAnimating()
            searchTableView.isHidden = true
        case .success:
            activityIndicator.isHidden = true
            searchTableView.isHidden = false
            searchTableView.reloadData()
        case let .failure(error):
            showAlert(error: error)
        }
    }

    private func configUI() {
        keyChainAlert()
        searchFilmViewModel.checkApiKey()
        setupSearchFilmState()
        searchFilmViewModel.loadMovies(category: URLRequest.popular)
        searchTableView.dataSource = self
        searchTableView.delegate = self
        view.addSubview(buttonsStackView)
        setConstraintsStackView()
        view.addSubview(searchTableView)
        setConstraintsTableView()
        view.addSubview(activityIndicator)
        setConstraintsActivityView()
    }

    private func keyChainAlert() {
        searchFilmViewModel.uploadApiKeyCompletion = { [weak self] in
            guard let self = self else { return }
            self.showApiKeyAlert(
                title: Constants.apiTitleText,
                message: Constants.apiMessageText,
                actionTitle: Constants.actionTitle
            ) { key in
                self.searchFilmViewModel.uploadApiKey(key)
                self.searchFilmViewModel.loadMovies(category: URLRequest.popular)
                self.searchTableView.reloadData()
            }
        }
    }

    private func setupSearchFilmState() {
        searchFilmViewModel.searchFilmStates = { [weak self] state in
            self?.searchScreenState = state
        }
    }

    private func setConstraintsTableView() {
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 10),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setConstraintsStackView() {
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            buttonsStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setConstraintsActivityView() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func showErrorAlert() {
        searchFilmViewModel.showErrorAlert = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert(error: error)
            }
        }
    }

    @objc private func sortingButtonAction(sender: UIButton) {
        searchFilmViewModel.sortingByCategory(tag: sender.tag)
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

@available(iOS 16.0, *)
extension SearchFilmViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchFilmViewModel.movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.movieCellId,
            for: indexPath
        ) as? MovieCell
        else { return UITableViewCell() }
        guard let movie = searchFilmViewModel.movies?[indexPath.row] else { return UITableViewCell() }
        cell.accessibilityIdentifier = "\(indexPath.row)"
        cell.configure(movie: movie, searchFilmViewModel: searchFilmViewModel)
        cell.alertDelegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = searchFilmViewModel.movies?[indexPath.row] else { return }
        toMovieDetailsModule?(movie)
    }
}

/// Alert delegate protocol
@available(iOS 16.0, *)
extension SearchFilmViewController: AlertDelegate {
    func showAlert(error: Error) {
        showAlert(
            title: Constants.errorTitle,
            message: error.localizedDescription,
            actionTitle: Constants.actionTitle,
            handler: nil
        )
    }
}
