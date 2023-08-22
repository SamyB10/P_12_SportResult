//
//  Header.swift
//  ResultSport
//
//  Created by Samy Boussair on 10/08/2023.
//

import UIKit
import Kingfisher

class HeaderCell: UICollectionViewCell {

    private var viewModel: StandingModels.ViewModel? {
        didSet {
            guard let viewModel, viewModel != oldValue else { return }
            updateInterface()
        }
    }

    // MARK: - Subviews

    private lazy var overallPts: UILabel = {
        let win = UILabel()
        win.font = .systemFont(ofSize: 15, weight: .bold)
        win.textColor = .white
        win.textAlignment = .center
        win.text = "PTS"
        win.translatesAutoresizingMaskIntoConstraints = false
        return win
    }()

    private lazy var labelWin: UILabel = {
        let win = UILabel()
        win.font = .systemFont(ofSize: 15, weight: .bold)
        win.textColor = .white
        win.textAlignment = .center
        win.text = "W"
        win.translatesAutoresizingMaskIntoConstraints = false
        return win
    }()

    private lazy var labelLose: UILabel = {
        let lose = UILabel()
        lose.font = .systemFont(ofSize: 15, weight: .bold)
        lose.textColor = .white
        lose.textAlignment = .center
        lose.text = "L"
        lose.translatesAutoresizingMaskIntoConstraints = false
        return lose
    }()

    private lazy var labelNul: UILabel = {
        let nul = UILabel()
        nul.font = .systemFont(ofSize: 15, weight: .bold)
        nul.textColor = .white
        nul.textAlignment = .center
        nul.translatesAutoresizingMaskIntoConstraints = false
        nul.text = "N"
        return nul
    }()

    private lazy var gamePlayed: UILabel = {
        let win = UILabel()
        win.font = .systemFont(ofSize: 15, weight: .bold)
        win.textColor = .white
        win.textAlignment = .center
        win.text = "MJ"
        win.translatesAutoresizingMaskIntoConstraints = false
        return win
    }()

    private lazy var labelChampionship: UILabel = {
        let win = UILabel()
        win.font = .systemFont(ofSize: 15, weight: .bold)
        win.textColor = .white
        win.textAlignment = .left
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
        setUpConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func setupInterface() {
        contentView.addSubview(stackViewGlobalGame)
        contentView.addSubview(labelChampionship)
        contentView.backgroundColor = .mainColor
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackViewGlobalGame.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewGlobalGame.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 20),
            stackViewGlobalGame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackViewGlobalGame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            labelChampionship.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelChampionship.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelChampionship.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            labelChampionship.trailingAnchor.constraint(equalTo: stackViewGlobalGame.leadingAnchor, constant: -10),
        ])
    }

    private func updateInterface() {
        guard let viewModel = viewModel else { return }
        labelChampionship.text = viewModel.leagueName
    }

    func configure(viewModel: StandingModels.ViewModel) {
        self.viewModel = viewModel
    }
}
