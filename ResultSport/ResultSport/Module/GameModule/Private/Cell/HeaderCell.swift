//
//  HeaderCell.swift
//  ResultSport
//
//  Created by Samy Boussair on 04/08/2023.
//

import UIKit
import Kingfisher

class HeaderCell: UICollectionViewCell {

    // MARK: - Subviews
    private lazy var nameLeague: UILabel = {
        let day = UILabel()
        day.textAlignment = .center
        day.font = .systemFont(ofSize: 18, weight: .bold)
        day.textColor = .white
        day.textAlignment = .left
        day.translatesAutoresizingMaskIntoConstraints = false
        return day
    }()

    private lazy var logoLeague: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        contentView.addSubview(nameLeague)
        contentView.addSubview(logoLeague)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            logoLeague.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            logoLeague.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            logoLeague.widthAnchor.constraint(equalToConstant: 40),
            logoLeague.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            nameLeague.topAnchor.constraint(equalTo: logoLeague.topAnchor),
            nameLeague.leadingAnchor.constraint(equalTo: logoLeague.trailingAnchor, constant: 15),
            nameLeague.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLeague.bottomAnchor.constraint(equalTo: logoLeague.bottomAnchor),
        ])
    }

    private func updateInterface() {
        guard let viewModel = viewModel else { return }
        let league = League.allCases
        let logoLeague = URL(string: "\(viewModel.leagueLogo)")

        league.forEach {
            guard $0.rawValue == viewModel.leagueId else {
                nameLeague.text = "Word"
                self.logoLeague.image = .actions
                return
            }
                self.logoLeague.kf.setImage(with: logoLeague)
                nameLeague.text = viewModel.leagueName
        }
    }

    func configure(viewModel: GameModels.ViewModel.Game) {
        self.viewModel = viewModel
    }
}
