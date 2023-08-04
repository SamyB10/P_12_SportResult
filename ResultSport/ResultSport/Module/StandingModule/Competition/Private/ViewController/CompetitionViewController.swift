//
//  SportViewController.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import UIKit
//import GameModuleKit

class CompetitionViewController: UIViewController {

    // MARK: - Subviews
    private lazy var competitionCollectionView: CompetitionCollectionView = {
        let collectionView = CompetitionCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.backgroundColor = .clear

        return collectionView
    }()

    // MARK: - Properties
    private var presenter: SportInteractionLogic?
    private var viewModel: [SportModels.ViewModel]? {
        didSet {
            guard let viewModel, viewModel != oldValue else { return }
            competitionCollectionView.snapShot(withViewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.mainColorTest.cgColor,
            UIColor.cellColorTest.cgColor,
        ]
        view.layer.addSublayer(gradientLayer)
        setupInterface()
        setupConstraints()
        presenter?.didLoad()
    }
    
    private func setupInterface() {
        view.addSubview(competitionCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            competitionCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            competitionCollectionView.trailingAnchor .constraint(equalTo: view.trailingAnchor),
            competitionCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            competitionCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func inject(presenter: SportInteractionLogic) {
        self.presenter = presenter
    }
}

extension CompetitionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewCOntroller = StandingViewController()
        navigationController?.pushViewController(StandingViewController(), animated: true)
//        print(viewModel?[indexPath.item].leagueName)
    }

}

extension CompetitionViewController: SportDisplayLogic {
    func displayInterface(with viewModel: [SportModels.ViewModel]) {
        updateInterface(with: viewModel)
    }
    
    func updateInterface(with viewModel: [SportModels.ViewModel]) {
        self.viewModel = viewModel
    }
    
    func displayError(with error: Error) {}
    
    func displayLoader() {}
}
