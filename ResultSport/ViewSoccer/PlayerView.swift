//
//  PlayerView.swift
//  ResultSport
//
//  Created by Samy Boussair on 29/08/2023.
//

import UIKit
import Kingfisher

class PlayerView: UIView {

    // MARK: - Subviews
    private lazy var imagePlayer: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    private let shirtNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    init(player: FootballPlayer) {
        super.init(frame: .zero)
        setupInterface()
        setupConstraints()
        configure(with: player)
        borderCercle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func setupInterface() {
        addSubview(nameLabel)
        addSubview(imagePlayer)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),

            imagePlayer.heightAnchor.constraint(equalToConstant: 30),
            imagePlayer.widthAnchor.constraint(equalToConstant: 30),
            imagePlayer.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5),
            imagePlayer.centerXAnchor.constraint(equalTo: centerXAnchor),

        ])
    }

    private func configure(with player: FootballPlayer) {
        let imagePlayer = URL(string: "https://apiv3.apifootball.com/badges/players/5705_mohamed-salah.jpg")
        self.imagePlayer.kf.setImage(with: imagePlayer)
        nameLabel.text = player.name
    }

    private func borderCercle() {
        imagePlayer.layer.cornerRadius = 30/2
    }
}

