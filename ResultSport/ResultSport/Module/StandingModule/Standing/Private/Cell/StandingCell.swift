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
        posititon.font = .systemFont(ofSize: 12, weight: .bold)
        posititon.textColor = .white
        posititon.translatesAutoresizingMaskIntoConstraints = false
        return posititon
    }()

    private lazy var teamName: UILabel = {
        let name = UILabel()
        name.textAlignment = .left
        name.font = .systemFont(ofSize: 12, weight: .regular)
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

        ])
    }

    private func updateInterface() {
        guard let viewModel = viewModel,
              let logoTeam = viewModel.teamLogo else { return }
        let teamLogo = URL(string: logoTeam)
        self.teamLogo.kf.setImage(with: teamLogo)
        teamName.text = viewModel.teamName
        positionTeam.text = viewModel.leaguePosition
    }

    private func borderCercle() {
        teamLogo.layer.cornerRadius = 30/2
    }

    func configure(viewModel: StandingModels.ViewModel) {
        self.viewModel = viewModel
    }
}
