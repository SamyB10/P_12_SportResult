//
//  SoccerViewController.swift
//  ResultSport
//
//  Created by Samy Boussair on 29/08/2023.
//

import UIKit

class GameDetailsViewController: UIViewController {

    private var presenter: GameDetailsInteractionLogic?
    private var gameId: String? {
        didSet {
            guard let gameId, gameId != oldValue else { return }
            activityIndicatorStart()
            presenter?.didFetchDetails(gameId: gameId)
        }
    }

    private var viewModel: [GameDetailsModels.ViewModel]? {
        didSet {
            guard let viewModel, viewModel != oldValue else { return }
            headerSoccerPitch.injectViewModel(with: viewModel)
            soccerPitch.injectViewModel(with: viewModel)
            collectionViewLineup.inject(viewModel: viewModel)
            activityIndicatorEnd()
        }
    }

    private var viewModelLineup: [GameDetailsModels.ViewModel.LineupTeam]? {
        didSet {
            guard let viewModelLineup, viewModelLineup != oldValue else { return }
            collectionViewLineup.injectLineup(viewModel: viewModelLineup)
        }
    }

    private lazy var scroolView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var soccerPitch: SoccerPitch = {
        let pitch = SoccerPitch()
        pitch.backgroundColor = .mainColor.withAlphaComponent(0.6)
        pitch.translatesAutoresizingMaskIntoConstraints = false
        return pitch
    }()

    private lazy var headerSoccerPitch: HeaderSoccerPitch = {
        let header = HeaderSoccerPitch()
        header.backgroundColor = .mainColor
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()

    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.backgroundColor = .mainColor
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private var collectionViewLineup: CollectionViewLineup = {
        let collectionView = CollectionViewLineup()
        collectionView.backgroundColor = .mainColor.withAlphaComponent(0.6)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    private lazy var lineupSegmented: LineupSegmented = {
        let lineupSegmented = LineupSegmented()
        lineupSegmented.translatesAutoresizingMaskIntoConstraints = false
        lineupSegmented.backgroundColor = .mainColor
        lineupSegmented.selectedSegmentIndex = 0
        lineupSegmented.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        return lineupSegmented
    }()

    func inject(presenter: GameDetailsInteractionLogic) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Game Details"
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.mainColor.cgColor,
            UIColor.cellColor.cgColor,
        ]
        view.layer.addSublayer(gradientLayer)
        setupInterface()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        lineupSegmented.selectedSegmentIndex = 0
    }

    func injectGameId(gameId: String) {
        self.gameId = gameId
    }

    private func setupInterface() {
        view.addSubview(scroolView)
        scroolView.addSubview(headerSoccerPitch)
        scroolView.addSubview(soccerPitch)
        soccerPitch.addSubview(activityIndicator)
        scroolView.addSubview(lineupSegmented)
        scroolView.addSubview(collectionViewLineup)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            scroolView.topAnchor.constraint(equalTo: view.topAnchor),
            scroolView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroolView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroolView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            headerSoccerPitch.topAnchor.constraint(equalTo: scroolView.topAnchor),
            headerSoccerPitch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerSoccerPitch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerSoccerPitch.heightAnchor.constraint(equalToConstant: 100),

            soccerPitch.topAnchor.constraint(equalTo: headerSoccerPitch.bottomAnchor, constant: 15),
            soccerPitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            soccerPitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            soccerPitch.heightAnchor.constraint(equalToConstant: 400),

            lineupSegmented.topAnchor.constraint(equalTo: soccerPitch.bottomAnchor, constant: 10),
            lineupSegmented.leadingAnchor.constraint(equalTo: soccerPitch.leadingAnchor),
            lineupSegmented.trailingAnchor.constraint(equalTo: soccerPitch.trailingAnchor),
            lineupSegmented.heightAnchor.constraint(equalToConstant: 20),

            collectionViewLineup.topAnchor.constraint(equalTo: lineupSegmented.bottomAnchor, constant: 10),
            collectionViewLineup.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewLineup.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionViewLineup.heightAnchor.constraint(equalToConstant: 410),
            collectionViewLineup.bottomAnchor.constraint(equalTo: scroolView.bottomAnchor)

        ])
    }

    private func activityIndicatorStart() {
        Task {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }

    private func activityIndicatorEnd() {
        Task {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }

    @objc private func segmentedValueChanged(_ sender: LineupSegmented) {
        presenter?.didSelectLineup(index: sender.selectedSegmentIndex)
    }
}

extension GameDetailsViewController: UIScrollViewDelegate {

}

extension GameDetailsViewController: GameDetailsDisplayLogic {
    func displayInterface(with viewModel: [GameDetailsModels.ViewModel]) {
        self.viewModel = viewModel
    }

    func updateInterface(with viewModel: [GameDetailsModels.ViewModel.LineupTeam]) {
        self.viewModelLineup = viewModel
    }

    func displayError(with error: Error) {
        
    }

    func displayLoader() {
    }
}
