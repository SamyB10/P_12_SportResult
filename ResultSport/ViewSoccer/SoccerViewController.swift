//
//  SoccerViewController.swift
//  ResultSport
//
//  Created by Samy Boussair on 29/08/2023.
//

import UIKit

class SoccerViewController: UIViewController {

    private lazy var soccerPitch: SoccerPitch = {
        let pitch = SoccerPitch()
        pitch.backgroundColor = .mainColor.withAlphaComponent(0.6)
        pitch.translatesAutoresizingMaskIntoConstraints = false
        return pitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Soccer Test"
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.mainColor.cgColor,
            UIColor.cellColor.cgColor,
        ]
        view.layer.addSublayer(gradientLayer)
        setupInterface()
        setupConstraints()
    }

    private func setupInterface() {
        view.addSubview(soccerPitch)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            soccerPitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            soccerPitch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            soccerPitch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            soccerPitch.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }

}
