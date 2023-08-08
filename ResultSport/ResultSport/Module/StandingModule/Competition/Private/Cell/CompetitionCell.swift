//
//  File.swift
//  
//
//  Created by Samy Boussair on 29/07/2023.
//

import UIKit
import Kingfisher
//import GameModuleKit


class CompetitionCell: UICollectionViewCell {

    // MARK: - Subviews
    private lazy var imageCountry: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var nameCountry: UILabel = {
        let name = UILabel()
        name.textAlignment = .left
        name.font = UIFont.italicSystemFont(ofSize: 14)
        name.font = UIFont.boldSystemFont(ofSize: 14)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var nameLeague: UILabel = {
        let name = UILabel()
        name.textAlignment = .left
        name.font = .systemFont(ofSize: 17, weight: .bold)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var imageLeague: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

//    private lazy var seasonLeague: UILabel = {
//        let season = UILabel()
//        season.textAlignment = .right
//        season.textColor = .gray
//        season.font = .systemFont(ofSize: 8, weight: .light)
//        season.translatesAutoresizingMaskIntoConstraints = false
//        return season
//    }()

    private var viewModel: CompetitionModels.ViewModel? {
        didSet {
            guard let viewModel, viewModel != oldValue else { return }
            updateInterface()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
        setUpConstraints()
        borderCell()
        borderCercle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func setupInterface() {
        contentView.backgroundColor = .mainColorTest.withAlphaComponent(0.6)
//        contentView.layer.borderColor = UIColor.black.cgColor
//        contentView.layer.borderWidth = 1
        contentView.addSubview(imageCountry)
        contentView.addSubview(nameCountry)
        contentView.addSubview(nameLeague)
        contentView.addSubview(imageLeague)
//        contentView.addSubview(seasonLeague)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageCountry.heightAnchor.constraint(equalToConstant: 55),
            imageCountry.widthAnchor.constraint(equalToConstant: 55),
            imageCountry.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            imageCountry.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            nameLeague.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLeague.leadingAnchor.constraint(equalTo: imageCountry.trailingAnchor, constant: 10),
            nameLeague.trailingAnchor.constraint(equalTo: imageLeague.leadingAnchor, constant: -10),
            nameLeague.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            nameCountry.topAnchor.constraint(equalTo: imageCountry.topAnchor),
            nameCountry.leadingAnchor.constraint(equalTo: nameLeague.leadingAnchor),
            nameCountry.trailingAnchor.constraint(equalTo: nameLeague.trailingAnchor),
            nameCountry.bottomAnchor.constraint(equalTo: nameLeague.topAnchor, constant: -3),

            imageLeague.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageLeague.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageLeague.widthAnchor.constraint(equalToConstant: 30),
            imageLeague.heightAnchor.constraint(equalToConstant: 30),
        ])
    }

    private func updateInterface() {
        guard let viewModel = viewModel else { return }
        let imageCountry = URL(string: "\(viewModel.countryLogo)")
        let imageLeague = URL(string: "\(viewModel.leagueLogo)")

//        self.imageCountry.image = .actions
//        self.imageLeague.image = .checkmark

        self.imageCountry.kf.setImage(with: imageCountry)
        self.imageLeague.kf.setImage(with: imageLeague)
        nameCountry.text = viewModel.countryName
        nameLeague.text = viewModel.leagueName
    }

    func configure(viewModel: CompetitionModels.ViewModel) {
        self.viewModel = viewModel
    }

    private func borderCell() {
        let cornerRadius: CGFloat = 10
        contentView.layer.cornerRadius = cornerRadius
//        contentView.layer.borderColor = UIColor.systemGray.cgColor
//        contentView.layer.borderWidth = 0.2
    }

    private func borderCercle() {
        imageCountry.layer.cornerRadius = 55/2
    }
}

