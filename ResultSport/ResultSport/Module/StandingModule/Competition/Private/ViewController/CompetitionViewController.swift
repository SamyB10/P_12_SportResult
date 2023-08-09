//
//  SportViewController.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import UIKit

class CompetitionViewController: UIViewController {

    // MARK: - Subviews
    private lazy var competitionCollectionView: CompetitionCollectionView = {
        let collectionView = CompetitionCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private var textField: UITextField = {
        let textField = UITextField()
        textField.accessibilityLabel = "Country ?"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Germany, England, French..."
        textField.backgroundColor = .clear
        textField.textColor = .white
        return textField
    }()

    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()


    // MARK: - Properties
    private var presenter: CompetitionInteractionLogic?
    private var viewModel: [CompetitionModels.ViewModel]? {
        didSet {
            activityIndicatorEnd()
            guard let viewModel, viewModel != oldValue else { return }
            competitionCollectionView.snapShot(withViewModel: viewModel)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.mainColor.cgColor,
            UIColor.cellColor.cgColor,
        ]
        view.layer.addSublayer(gradientLayer)
        setupInterface()
        setupConstraints()
        presenter?.didLoad()
    }

    private func setupInterface() {
        view.addSubview(competitionCollectionView)
        view.addSubview(textField)
        competitionCollectionView.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.trailingAnchor .constraint(equalTo: view.trailingAnchor, constant: -25),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textField.bottomAnchor.constraint(equalTo: competitionCollectionView.topAnchor, constant: -20),

            competitionCollectionView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            competitionCollectionView.trailingAnchor .constraint(equalTo: view.trailingAnchor),
            competitionCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            competitionCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: competitionCollectionView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: competitionCollectionView.centerYAnchor),
        ])
    }
    
    func inject(presenter: CompetitionInteractionLogic) {
        self.presenter = presenter
    }

    private func activityIndicatorStart() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func activityIndicatorEnd() {
        Task {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
}

extension CompetitionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let leagueId = viewModel?[indexPath.row].leagueId else { return }
        presenter?.didSelect(id: leagueId)
    }
}

extension CompetitionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        guard let country = textField.text else { return }
        activityIndicatorStart()
        presenter?.searchCompetition(country: country)
    }
}

extension CompetitionViewController: CompetitionDisplayLogic {
    func displayInterface(with viewModel: [CompetitionModels.ViewModel]) {
        updateInterface(with: viewModel)
    }
    
    func updateInterface(with viewModel: [CompetitionModels.ViewModel]) {
        self.viewModel = viewModel
    }
    
    func displayError(with error: Error) {}
    
    func displayLoader() {
        activityIndicatorStart()
    }
}
