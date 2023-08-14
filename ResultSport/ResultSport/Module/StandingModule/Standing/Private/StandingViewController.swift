//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import UIKit

class StandingViewController: UIViewController {

    private var presenter: StandingInteractionLogic?
    private var idLeague: String? {
        didSet {
            guard let idLeague, idLeague != oldValue else { return }
            presenter?.didFetchLeague(leagueId: idLeague)
        }
    }
    private var viewModel: [StandingModels.ViewModel]? {
        didSet {
            guard let viewModel, viewModel != oldValue else { return }
            collectionView.snapShot(with: viewModel)
        }
    }

    private lazy var collectionView: StandingCollectionView = {
        let collectionView = StandingCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.mainColor.cgColor,
            UIColor.cellColor.cgColor,
        ]
        view.layer.addSublayer(gradientLayer)
        self.title = "Standing"
        setupInterface()
        setupConstraints()
    }

    func inject(leagueId: String) {
        self.idLeague = leagueId
    }

    private func setupInterface() {
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func inject(presenter: StandingInteractionLogic) {
        self.presenter = presenter
    }
}

extension StandingViewController: StandingDisplayLogic {
    func displayInterface(with viewModel: [StandingModels.ViewModel]) {
        self.viewModel = viewModel
    }

    func updateInterface(with viewModel: [StandingModels.ViewModel]) {}

    func displayError(with error: Error) {
        let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        Task {
            present(alertController, animated: true, completion: nil)
        }
    }

    func displayLoader() {}
}
