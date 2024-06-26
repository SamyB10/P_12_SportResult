//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import UIKit

class StandingViewController: UIViewController {

    //MARK: - Property
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
                self.collectionView.snapShot(with: viewModel)
        }
    }

    //MARK: - Subviews
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private lazy var collectionView: StandingCollectionView = {
        let collectionView = StandingCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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

    private func activityIndicatorStart() {
        Task {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }

    private func activityIndicatorEnd() {
        Task {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let gradientLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer.frame = CGRect(origin: .zero, size: size)
        }
    }

    func inject(leagueId: String) {
        self.idLeague = leagueId
    }

    func inject(presenter: StandingInteractionLogic) {
        self.presenter = presenter
    }

    private func setupInterface() {
        view.addSubview(collectionView)
        collectionView.addSubview(activityIndicator)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),

        ])
    }
}

extension StandingViewController: StandingDisplayLogic {
    func displayInterface(with viewModel: [StandingModels.ViewModel]) {
        activityIndicatorEnd()
        updateInterface(with: viewModel)
    }

    func updateInterface(with viewModel: [StandingModels.ViewModel]) {
        self.viewModel = viewModel
    }

    func displayError(with error: Error) {
        activityIndicatorEnd()
        let alertController = UIAlertController(title: "Error",
                                                message: "\(error.localizedDescription) Please selected other championsShip",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)

        present(alertController, animated: true,
                completion: nil)
    }

    func displayLoader() {
        activityIndicatorStart()
    }
}
