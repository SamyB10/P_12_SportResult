//
//  GameCell.swift
//  
//
//  Created by Samy Boussair on 02/08/2023.
//

import UIKit
import Kingfisher

class GameCell: UICollectionViewCell {

    // MARK: - Subviews
    private lazy var nameHomeTeam: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var stadium: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var scoreHomeTeam: UILabel = {
        let score = UILabel()
        score.textAlignment = .center
        score.font = .monospacedSystemFont(ofSize: 18, weight: .bold)
        score.textColor = .white
        score.translatesAutoresizingMaskIntoConstraints = false
        return score
    }()

    private lazy var logoHomeTeam: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var matchTime: UILabel = {
        let time = UILabel()
        time.textAlignment = .center
        time.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        time.textColor = .white
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()

    private lazy var nameAwayTeam: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var logoAwayTeam: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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

    private lazy var stackViewScore: UIStackView = {
        let score = UIStackView(arrangedSubviews: [scoreHomeTeam,
                                                   betweenScore,
                                                   scoreAwayTeam])
        score.alignment = .center
        score.distribution = .fillProportionally
        score.translatesAutoresizingMaskIntoConstraints = false
        return score
    }()

    private var viewModel: GameModels.ViewModel.Game? {
        didSet {
            guard let viewModel, viewModel != oldValue else { return }
            updateInterface()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
        setUpConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func setupInterface() {
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .mainColor.withAlphaComponent(0.6)
        contentView.addSubview(nameHomeTeam)
        contentView.addSubview(logoHomeTeam)
        contentView.addSubview(stackViewScore)
        contentView.addSubview(nameAwayTeam)
        contentView.addSubview(logoAwayTeam)
//        contentView.addSubview(stadium)
        contentView.addSubview(matchTime)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([

            logoHomeTeam.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoHomeTeam.widthAnchor.constraint(equalToConstant: 70),
            logoHomeTeam.centerXAnchor.constraint(equalTo: nameHomeTeam.centerXAnchor),
            logoHomeTeam.heightAnchor.constraint(equalToConstant: 70),

            nameHomeTeam.topAnchor.constraint(equalTo: logoHomeTeam.bottomAnchor, constant: 5),
            nameHomeTeam.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameHomeTeam.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -10),
            nameHomeTeam.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            stackViewScore.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackViewScore.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackViewScore.heightAnchor.constraint(equalToConstant: 70),
            stackViewScore.widthAnchor.constraint(equalToConstant: 90),

            logoAwayTeam.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoAwayTeam.centerXAnchor.constraint(equalTo: nameAwayTeam.centerXAnchor),
            logoAwayTeam.widthAnchor.constraint(equalTo: logoHomeTeam.widthAnchor),
            logoAwayTeam.heightAnchor.constraint(equalTo: logoHomeTeam.heightAnchor),

            nameAwayTeam.topAnchor.constraint(equalTo: nameHomeTeam.topAnchor),
            nameAwayTeam.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            nameAwayTeam.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameAwayTeam.bottomAnchor.constraint(equalTo: nameHomeTeam.bottomAnchor),

            matchTime.heightAnchor.constraint(equalToConstant: 20),
            matchTime.leadingAnchor.constraint(equalTo: stackViewScore.leadingAnchor),
            matchTime.trailingAnchor.constraint(equalTo: stackViewScore.trailingAnchor),
            matchTime.bottomAnchor.constraint(equalTo: stackViewScore.topAnchor, constant: -10),
            //
            //            stadium.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            //            stadium.leadingAnchor.constraint(equalTo: logoHomeTeam.leadingAnchor),
            //            stadium.trailingAnchor.constraint(equalTo: logoAwayTeam.trailingAnchor),
            //            stadium.bottomAnchor.constraint(equalTo: stackViewScore.topAnchor, constant: -20),
        ])
    }

    private func updateInterface() {
        guard let viewModel = viewModel else { return }
        let logoHomeTeam = URL(string: "\(viewModel.homeBadge)")
        let logoAwayTeam = URL(string: "\(viewModel.awayBadge)")

        stadium.text = viewModel.stadium
        nameHomeTeam.text = viewModel.homeTeamName
        nameAwayTeam.text = viewModel.awayTeamName
        self.logoHomeTeam.kf.setImage(with: logoHomeTeam)
        self.logoAwayTeam.kf.setImage(with: logoAwayTeam)
        scoreHomeTeam.text = viewModel.homeTeamScore
        scoreAwayTeam.text = viewModel.awayTeamScore
        matchTime.text = viewModel.matchTime
    }

    func configure(viewModel: GameModels.ViewModel.Game) {
        self.viewModel = viewModel
    }
}

