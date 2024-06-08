//
//  SoccerPitch.swift
//  ResultSport
//
//  Created by Samy Boussair on 29/08/2023.
//

import Foundation
import UIKit

struct FootballPlayer {
    let name: String
    let position: String
    let shirtNumber: Int
    let image: String
    let playerHome: Bool
}

class SoccerPitch: UIView {

    private var viewModel: [GameDetailsModels.ViewModel]? {
        didSet {
            createPlayerHome()
            createPlayerAway()
        }
    }

    private lazy var halfwayLine: UIView = {
        let halfwayLine = UIView()
        halfwayLine.backgroundColor = .gray
        halfwayLine.translatesAutoresizingMaskIntoConstraints = false
        return halfwayLine
    }()

    private lazy var centerCircle: UIView = {
        let centerCircle = UIView()
        centerCircle.backgroundColor = .clear
        centerCircle.translatesAutoresizingMaskIntoConstraints = false
        centerCircle.layer.borderWidth = 1
        centerCircle.layer.borderColor = UIColor.gray.cgColor
        return centerCircle
    }()

    private lazy var penaltyBoxHome: UIView = {
        let penaltyBox = UIView()
        penaltyBox.backgroundColor = .clear
        penaltyBox.translatesAutoresizingMaskIntoConstraints = false
        penaltyBox.layer.borderWidth = 1
        penaltyBox.layer.borderColor = UIColor.gray.cgColor
        return penaltyBox
    }()

    private lazy var penaltyBoxAway: UIView = {
        let penaltyBox = UIView()
        penaltyBox.backgroundColor = .clear
        penaltyBox.translatesAutoresizingMaskIntoConstraints = false
        penaltyBox.layer.borderWidth = 1
        penaltyBox.layer.borderColor = UIColor.gray.cgColor
        return penaltyBox
    }()

    private lazy var playerContainerHome: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var playerContainerAway: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    func injectViewModel(with viewModel: [GameDetailsModels.ViewModel]) {
        self.viewModel = viewModel
    }

    private func createPlayer(viewModel: [GameDetailsModels.ViewModel.LineupTeam],
                              playerHome: Bool) -> [FootballPlayer]? {
        var players: [FootballPlayer] = []
        let countPlayer = viewModel.count
        for i in 0..<countPlayer {
            guard let namePlayer = viewModel[i].namePlayer,
                  let positionPlayer = viewModel[i].postionPlayer,
                  let shirtNumber = viewModel[i].numberPlayer,
                  let imagePlayer = viewModel[i].idPlayer,
                  let intShirtNumber = Int(shirtNumber) else { return nil }
            let player = FootballPlayer(name: namePlayer,
                                        position: positionPlayer,
                                        shirtNumber: intShirtNumber,
                                        image: imagePlayer,
                                        playerHome: playerHome)
            players.append(player)
        }
        return players
    }


    private func createPlayerHome() {
        guard let viewModel = viewModel?.first?.home,
              let teamHome = createPlayer(viewModel: viewModel, playerHome: true) else { return }
        updatePlayerDetailsHome(teamComposition: teamHome)
    }

    private func createPlayerAway() {
        guard let viewModel = viewModel?.first?.away,
              let teamAway = createPlayer(viewModel: viewModel, playerHome: false) else { return }
        updatePlayerDetailsAway(teamComposition: teamAway)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
        setupConstraints()
        cercleCenter()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func setupInterface() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        addSubview(halfwayLine)
        addSubview(centerCircle)
        addSubview(penaltyBoxHome)
        addSubview(penaltyBoxAway)
        addSubview(playerContainerHome)
        addSubview(playerContainerAway)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            halfwayLine.heightAnchor.constraint(equalToConstant: 3),
            halfwayLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            halfwayLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            halfwayLine.topAnchor.constraint(equalTo: centerYAnchor),

            centerCircle.heightAnchor.constraint(equalToConstant: 80),
            centerCircle.widthAnchor.constraint(equalToConstant: 80),
            centerCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerCircle.centerXAnchor.constraint(equalTo: centerXAnchor),

            penaltyBoxHome.topAnchor.constraint(equalTo: topAnchor),
            penaltyBoxHome.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            penaltyBoxHome.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            penaltyBoxHome.heightAnchor.constraint(equalToConstant: 80),

            penaltyBoxAway.bottomAnchor.constraint(equalTo: bottomAnchor),
            penaltyBoxAway.leadingAnchor.constraint(equalTo: penaltyBoxHome.leadingAnchor),
            penaltyBoxAway.trailingAnchor.constraint(equalTo: penaltyBoxHome.trailingAnchor),
            penaltyBoxAway.heightAnchor.constraint(equalTo: penaltyBoxHome.heightAnchor),

            playerContainerHome.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerContainerHome.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerContainerHome.topAnchor.constraint(equalTo: topAnchor),
            playerContainerHome.bottomAnchor.constraint(equalTo: halfwayLine.topAnchor),

            playerContainerAway.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerContainerAway.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerContainerAway.topAnchor.constraint(equalTo: halfwayLine.bottomAnchor),
            playerContainerAway.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }

    private func setupRowStackView(rowStackView: UIStackView, container: UIStackView) {
        rowStackView.axis = .horizontal
        rowStackView.alignment = .center
        rowStackView.distribution = .fillEqually
        container.addArrangedSubview(rowStackView)
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rowStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            rowStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
    }

    private func updatePlayerDetails(teamComposition: [FootballPlayer],
                                     container: UIStackView,
                                     systeme: String?) {
        DispatchQueue.main.async {
            container.arrangedSubviews.forEach { $0.removeFromSuperview() }
            guard teamComposition.count == 11 else { return }
            guard systeme != "" else { return }
            var playerViews = teamComposition.map { PlayerView(player: $0) }
            for playerView in playerViews {
                container.addArrangedSubview(playerView)
            }

            guard let fullSysteme = systeme else { return }
            let splitSysteme = fullSysteme.split(separator: "-")

            let playersSlice = Array(playerViews.prefix(1))
            let rowStackView = UIStackView(arrangedSubviews: playersSlice)
            container.addArrangedSubview(rowStackView)
            playerViews.removeFirst(1)

            for count in splitSysteme {
                guard let numberOfPlayers = Int(count) else { return }
                let playersSlice = Array(playerViews.prefix(numberOfPlayers))
                let rowStackView = UIStackView(arrangedSubviews: playersSlice)
                self.setupRowStackView(rowStackView: rowStackView, container: container)
                playerViews.removeFirst(numberOfPlayers)
            }
        }
    }

    private func updatePlayerDetailsAway(teamComposition: [FootballPlayer],
                                         container: UIStackView,
                                         systeme: String?) {
        DispatchQueue.main.async {
            container.arrangedSubviews.forEach { $0.removeFromSuperview() }
            guard teamComposition.count == 11 else { return }
            guard systeme != "" else { return }
            var playerViews = teamComposition.map { PlayerView(player: $0) }
            for playerView in playerViews {
                container.addArrangedSubview(playerView)
            }

            guard let fullSysteme = systeme else { return }
            let splitSysteme = fullSysteme.split(separator: "-")

            for count in splitSysteme.reversed() {
                guard let numberOfPlayers = Int(count) else { return }
                let playersSlice = Array(playerViews.suffix(numberOfPlayers))
                let rowStackView = UIStackView(arrangedSubviews: playersSlice)
                self.setupRowStackView(rowStackView: rowStackView, container: container)
                playerViews.removeLast(numberOfPlayers)
            }
            let playersSlice = Array(playerViews.prefix(1))
            let rowStackView = UIStackView(arrangedSubviews: playersSlice)
            container.addArrangedSubview(rowStackView)
            playerViews.removeFirst(1)
        }
    }

    private func updatePlayerDetailsHome(teamComposition: [FootballPlayer]) {
        let systeme = viewModel?.first?.homeTeamSysteme
        updatePlayerDetails(teamComposition: teamComposition,
                            container: playerContainerHome,
                            systeme: systeme)
    }

    private func updatePlayerDetailsAway(teamComposition: [FootballPlayer]) {
        let systeme = viewModel?.first?.awayTeamSysteme
        updatePlayerDetailsAway(teamComposition: teamComposition,
                                container: playerContainerAway,
                                systeme: systeme)
    }

    private func cercleCenter() {
        centerCircle.layer.cornerRadius = 80/2
    }
}
