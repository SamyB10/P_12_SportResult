//
//  HeaderSoccerPitch.swift
//  ResultSport
//
//  Created by Samy Boussair on 02/09/2023.
//

import UIKit

class HeaderSoccerPitch: UIView {

    private var viewModel: [GameDetailsModels.ViewModel]? {
        didSet {
            updateInterface()
        }
    }

    private lazy var nameTeamHome: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textAlignment = .center
        name.textColor = .white
        name.font = .systemFont(ofSize: 14)
        return name
    }()

    private lazy var nameTeamAway: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textAlignment = .center
        name.textColor = .white
        name.font = .systemFont(ofSize: 14)
        return name
    }()

    private lazy var logoHomeTeam: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var logoAwayTeam: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var scoreHomeTeam: UILabel = {
        let score = UILabel()
        score.textAlignment = .center
        score.font = .monospacedSystemFont(ofSize: 18, weight: .bold)
        score.textColor = .white
        score.translatesAutoresizingMaskIntoConstraints = false
        return score
    }()

    private lazy var scoreAwayTeam: UILabel = {
        let score = UILabel()
        score.textAlignment = .center
        score.font = .monospacedSystemFont(ofSize: 18, weight: .bold)
        score.textColor = .white
        score.translatesAutoresizingMaskIntoConstraints = false
        return score
    }()

    private lazy var betweenScore: UILabel = {
        let betweenScore = UILabel()
        betweenScore.textAlignment = .center
        betweenScore.font = .monospacedSystemFont(ofSize: 18, weight: .bold)
        betweenScore.textColor = .white
        betweenScore.text = ":"
        betweenScore.translatesAutoresizingMaskIntoConstraints = false
        return betweenScore
    }()

    private lazy var statusMatch: UILabel = {
        let status = UILabel()
        status.textAlignment = .center
        status.font = .systemFont(ofSize: 14)
        status.textColor = .white
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()

    private lazy var stackViewScore: UIStackView = {
        let score = UIStackView(arrangedSubviews: [scoreHomeTeam,
                                                   betweenScore,
                                                   scoreAwayTeam])
        score.alignment = .center
        score.distribution = .fillProportionally
        score.translatesAutoresizingMaskIntoConstraints = false
        return score
    }()

    func injectViewModel(with viewModel: [GameDetailsModels.ViewModel]) {
        self.viewModel = viewModel
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func setupInterface() {
        addSubview(stackViewScore)
        addSubview(logoHomeTeam)
        addSubview(logoAwayTeam)
        addSubview(nameTeamHome)
        addSubview(nameTeamAway)
        stackViewScore.addSubview(statusMatch)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            stackViewScore.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViewScore.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViewScore.heightAnchor.constraint(equalToConstant: 100),
            stackViewScore.widthAnchor.constraint(equalToConstant: 120),

            logoHomeTeam.trailingAnchor.constraint(equalTo: stackViewScore.leadingAnchor, constant: -10),
            logoHomeTeam.centerYAnchor.constraint(equalTo: stackViewScore.centerYAnchor),
            logoHomeTeam.widthAnchor.constraint(equalToConstant: 50),
            logoHomeTeam.heightAnchor.constraint(equalToConstant: 50),

            logoAwayTeam.leadingAnchor.constraint(equalTo: stackViewScore.trailingAnchor, constant: 10),
            logoAwayTeam.centerYAnchor.constraint(equalTo: logoHomeTeam.centerYAnchor),
            logoAwayTeam.widthAnchor.constraint(equalTo: logoHomeTeam.widthAnchor),
            logoAwayTeam.heightAnchor.constraint(equalTo: logoHomeTeam.heightAnchor),

            nameTeamHome.topAnchor.constraint(equalTo: logoHomeTeam.bottomAnchor, constant: 3),
            nameTeamHome.centerXAnchor.constraint(equalTo: logoHomeTeam.centerXAnchor),
            nameTeamHome.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),

            nameTeamAway.topAnchor.constraint(equalTo: nameTeamHome.topAnchor),
            nameTeamAway.centerXAnchor.constraint(equalTo: logoAwayTeam.centerXAnchor),
            nameTeamAway.bottomAnchor.constraint(equalTo: nameTeamHome.bottomAnchor),

            statusMatch.topAnchor.constraint(equalTo: scoreHomeTeam.bottomAnchor, constant: 2),
            statusMatch.centerXAnchor.constraint(equalTo: stackViewScore.centerXAnchor),
            statusMatch.bottomAnchor.constraint(equalTo: nameTeamHome.topAnchor),
        ])
    }

    private func updateInterface() {
        Task {
            guard let logoHome = viewModel?.first?.teamHomeLogo,
                  let logoAway = viewModel?.first?.teamAwayLogo else { return }
            let logoTeamHome = URL(string: logoHome)
            let logoTeamAway = URL(string: logoAway)
            self.logoHomeTeam.kf.setImage(with: logoTeamHome)
            self.logoAwayTeam.kf.setImage(with: logoTeamAway)
            scoreHomeTeam.text = viewModel?.first?.scoreTeamHome
            scoreAwayTeam.text = viewModel?.first?.scoreTeamAway
            nameTeamHome.text = viewModel?.first?.nameTeamHome
            nameTeamAway.text = viewModel?.first?.nameTeamAway
            statusMatch.text = viewModel?.first?.statusMatch
        }
    }
}
