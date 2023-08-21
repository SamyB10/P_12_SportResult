//
//  standingCell.swift
//  ResultSport
//
//  Created by Samy Boussair on 08/08/2023.
//

import UIKit

class StandingCell: UICollectionViewCell {

    // MARK: - Subviews
    private lazy var positionTeam: UILabel = {
        let posititon = UILabel()
        posititon.textAlignment = .center
        posititon.font = .systemFont(ofSize: 15, weight: .bold)
        posititon.textColor = .white
        posititon.translatesAutoresizingMaskIntoConstraints = false
        return posititon
    }()

    private lazy var overallPts: UILabel = {
        let posititon = UILabel()
        posititon.textAlignment = .center
        posititon.font = .systemFont(ofSize: 15, weight: .regular)
        posititon.textColor = .white
        posititon.translatesAutoresizingMaskIntoConstraints = false
        return posititon
    }()

    private lazy var teamName: UILabel = {
        let name = UILabel()
        name.textAlignment = .left
        name.font = .systemFont(ofSize: 13, weight: .regular)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var teamLogo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var labelWin: UILabel = {
        let win = UILabel()
        win.textAlignment = .center
        win.font = .systemFont(ofSize: 13, weight: .regular)
        win.textColor = .white
        win.translatesAutoresizingMaskIntoConstraints = false
        return win
    }()

    private lazy var labelLose: UILabel = {
        let lose = UILabel()
        lose.textAlignment = .center
        lose.font = .systemFont(ofSize: 13, weight: .regular)
        lose.textColor = .white
        lose.translatesAutoresizingMaskIntoConstraints = false
        return lose
    }()

    private lazy var labelNul: UILabel = {
        let nul = UILabel()
        nul.textAlignment = .center
        nul.font = .systemFont(ofSize: 13, weight: .regular)
        nul.textColor = .white
        nul.translatesAutoresizingMaskIntoConstraints = false
        return nul
    }()

    private lazy var gamePlayed: UILabel = {
        let win = UILabel()
        win.font = .systemFont(ofSize: 13, weight: .regular)
        win.textColor = .white
        win.textAlignment = .center
        win.translatesAutoresizingMaskIntoConstraints = false
        return win
    }()

    private lazy var stackViewGlobalGame: UIStackView = {
        let stackViewGlobalGame = UIStackView(arrangedSubviews: [overallPts,
                                                                 labelWin,
                                                                 labelNul,
                                                                 labelLose,
                                                                 gamePlayed])
        stackViewGlobalGame.alignment = .center
        stackViewGlobalGame.distribution = .fillEqually
        stackViewGlobalGame.translatesAutoresizingMaskIntoConstraints = false
        return stackViewGlobalGame
    }()

    private var viewModel: StandingModels.ViewModel? {
        didSet {
            guard let viewModel, viewModel != oldValue else { return }
            updateInterface()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
        setUpConstraints()
        borderCercle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func setupInterface() {
        contentView.backgroundColor = .mainColor.withAlphaComponent(0.6)
        contentView.addSubview(teamName)
        contentView.addSubview(teamLogo)
        contentView.addSubview(positionTeam)
        contentView.addSubview(stackViewGlobalGame)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([

            positionTeam.topAnchor.constraint(equalTo: contentView.topAnchor),
            positionTeam.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            positionTeam.widthAnchor.constraint(equalToConstant: 20),
            positionTeam.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            teamLogo.leadingAnchor.constraint(equalTo: positionTeam.trailingAnchor, constant: 10),
            teamLogo.centerYAnchor.constraint(equalTo: positionTeam.centerYAnchor),
            teamLogo.widthAnchor.constraint(equalToConstant: 30),
            teamLogo.heightAnchor.constraint(equalToConstant: 30),

            teamName.topAnchor.constraint(equalTo: contentView.topAnchor),
            teamName.leadingAnchor.constraint(equalTo: teamLogo.trailingAnchor, constant: 10),
            teamName.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            teamName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            stackViewGlobalGame.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewGlobalGame.leadingAnchor.constraint(equalTo: teamName.trailingAnchor, constant: 20),
            stackViewGlobalGame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackViewGlobalGame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ])
    }

    private func updateInterface() {
        guard let viewModel = viewModel,
              let logoTeam = viewModel.teamLogo,
              let gameLose = Int(viewModel.gameLose ?? "0"),
              let gameNul = Int(viewModel.gameNul ?? "0"),
              let gameWin = Int(viewModel.gameWin ?? "0") else { return }
        let gamePlayedInt = gameLose + gameNul + gameWin

        let teamLogo = URL(string: logoTeam)
        self.teamLogo.kf.setImage(with: teamLogo)
        teamName.text = viewModel.teamName
        positionTeam.text = viewModel.leaguePosition
        labelWin.text = viewModel.gameWin
        labelNul.text = viewModel.gameNul
        labelLose.text = viewModel.gameLose
        gamePlayed.text = String(gamePlayedInt)
        overallPts.text = viewModel.standingPts
    }

    private func borderCercle() {
        teamLogo.layer.cornerRadius = 30/2
    }

    func configure(viewModel: StandingModels.ViewModel) {
        self.viewModel = viewModel
    }
}
