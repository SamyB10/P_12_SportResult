//
//  SearchViewController.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import UIKit

class StandingViewController: UIViewController {

    private var presenter: StandingInteractionLogic?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        self.navigationController?.navigationBar.backgroundColor = .white
        setupInterface()
        setupConstraints()
    }

    private func setupInterface() {
    }

    private func setupConstraints() {
    }
    
    func inject(presenter: StandingInteractionLogic) {
        self.presenter = presenter
    }
}

extension StandingViewController: StandingDisplayLogic {
    func displayInterface(with viewModel: [StandingModels.ViewModel]) {}

    func updateInterface(with viewModel: [StandingModels.ViewModel]) {}

    func displayError(with error: Error) {}

    func displayLoader() {}
}
