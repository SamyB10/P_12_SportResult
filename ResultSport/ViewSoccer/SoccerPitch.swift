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
}

final class SoccerPitch: UIView {

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


    func createPlayer() {
        var arrayTest: [FootballPlayer] = []
        for i in 1...11 {
            let player = FootballPlayer(name: "Player \(i)", position: "Position \(i)", shirtNumber: i)
            arrayTest.append(player)
        }
        updatePlayerDetails(teamComposition: arrayTest)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
        setupConstraints()
        cercleCenter()
        createPlayer()
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
            playerContainerHome.bottomAnchor.constraint(equalTo: halfwayLine.topAnchor)
        ])
    }

    func updatePlayerDetails(teamComposition: [FootballPlayer]) {
        playerContainerHome.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for player in teamComposition {
            let playerView = PlayerView(player: player)
            playerContainerHome.addArrangedSubview(playerView)
        }


//        mettre ici if viewModelPosition = 4-3-4
        if teamComposition.count == 11 {

            let goal = playerContainerHome.arrangedSubviews.prefix(1)
            let defender = playerContainerHome.arrangedSubviews[1...5]
            let midfielder = playerContainerHome.arrangedSubviews[5...7]
            let striker = playerContainerHome.arrangedSubviews.suffix(3)

            let goalArray = Array(goal)
            let defenderArray = Array(defender)
            let midfielderArray = Array(midfielder)
            let strikerArray = Array(striker)


            let goalRowStackView = UIStackView(arrangedSubviews: goalArray)
            let defenderRowStackView = UIStackView(arrangedSubviews: defenderArray)
            let midfielderRowStackView = UIStackView(arrangedSubviews: midfielderArray)
            let strikerRowStackView = UIStackView(arrangedSubviews: strikerArray)


            playerContainerHome.addArrangedSubview(goalRowStackView)
            playerContainerHome.addArrangedSubview(defenderRowStackView)
            playerContainerHome.addArrangedSubview(midfielderRowStackView)
            playerContainerHome.addArrangedSubview(strikerRowStackView)

        }
    }

    private func cercleCenter() {
        centerCircle.layer.cornerRadius = 80/2
    }
}
