//
//  CellLineup.swift
//  ResultSport
//
//  Created by Samy Boussair on 04/09/2023.
//

import UIKit

class CellLineup: UICollectionViewCell {

    // MARK: - Subviews

    private lazy var namePlayer: UILabel = {
        let namePlayer = UILabel()
        namePlayer.textAlignment = .left
        namePlayer.font = .systemFont(ofSize: 14)
        namePlayer.textColor = .white
        namePlayer.translatesAutoresizingMaskIntoConstraints = false
        return namePlayer
    }()

    private lazy var numberPlayer: UILabel = {
        let namePlayer = UILabel()
        namePlayer.textAlignment = .center
        namePlayer.font = .systemFont(ofSize: 14, weight: .bold)
        namePlayer.textColor = .white
        namePlayer.translatesAutoresizingMaskIntoConstraints = false
        return namePlayer
    }()

    private lazy var scorer: UILabel = {
        let scorer = UILabel()
        scorer.textAlignment = .center
        scorer.translatesAutoresizingMaskIntoConstraints = false
        return scorer
    }()

    private var viewModel: GameDetailsModels.ViewModel.LineupTeam? {
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
        contentView.addSubview(namePlayer)
        contentView.addSubview(scorer)
        contentView.addSubview(numberPlayer)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            namePlayer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            namePlayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            namePlayer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            scorer.topAnchor.constraint(equalTo: namePlayer.topAnchor),
            scorer.leadingAnchor.constraint(equalTo: namePlayer.trailingAnchor, constant: 5),
            scorer.bottomAnchor.constraint(equalTo: namePlayer.bottomAnchor),

            numberPlayer.topAnchor.constraint(equalTo: topAnchor),
            numberPlayer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            numberPlayer.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func updateInterface() {
        contentView.backgroundColor = .mainColor
        namePlayer.text = viewModel?.namePlayer
        numberPlayer.text = viewModel?.numberPlayer
    }

    func configure(viewModel: GameDetailsModels.ViewModel.LineupTeam) {
        scorer.text = ""
        self.viewModel = viewModel
        guard let goalScorer = viewModel.goalScorer else { return }

        guard goalScorer else {
            namePlayer.text = viewModel.namePlayer
            return
        }
        scorer.text = "⚽️"
    }
}
