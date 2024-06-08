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
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let shirtNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .bold)
        return label
    }()

    init(player: FootballPlayer) {
        super.init(frame: .zero)
        setupInterface()
        setupConstraints()
        configureHome(with: player)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func setupInterface() {
        addSubview(imagePlayer)
        imagePlayer.addSubview(shirtNumberLabel)
        addSubview(nameLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        borderCercle()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            imagePlayer.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            imagePlayer.centerXAnchor.constraint(equalTo: centerXAnchor),
            imagePlayer.widthAnchor.constraint(equalToConstant: 35),
            imagePlayer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            shirtNumberLabel.topAnchor.constraint(equalTo: imagePlayer.topAnchor, constant: 2),
            shirtNumberLabel.leadingAnchor.constraint(equalTo: imagePlayer.leadingAnchor),
            shirtNumberLabel.trailingAnchor.constraint(equalTo: imagePlayer.trailingAnchor),
            shirtNumberLabel.bottomAnchor.constraint(equalTo: imagePlayer.centerYAnchor),

            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imagePlayer.bottomAnchor, constant: 1),
        ])
    }

    private func configureHome(with player: FootballPlayer) {
        let fullName = player.name
        let nameComponents = fullName.split(separator: " ")
        guard let lastName = nameComponents.last else { return }
        nameLabel.text = String(lastName)
        guard player.image != "" else {
            imagePlayer.image = UIImage(named: "placeholderImage")
            return
        }

        guard player.playerHome else {
            imagePlayer.image = UIImage(named: "shirtAway")
            shirtNumberLabel.text = String(player.shirtNumber)
            return
        }
        imagePlayer.image = UIImage(named: "shirtHome")
        shirtNumberLabel.text = String(player.shirtNumber)
    }

    private func borderCercle() {
//        imagePlayer.layer.cornerRadius = imagePlayer.bounds.height / 2.0
    }
}

