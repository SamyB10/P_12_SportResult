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
        textField.backgroundColor = .white
        return textField
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
        view.addSubview(textField)
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
        ])
    }
    
    func inject(presenter: SportInteractionLogic) {
        self.presenter = presenter
    }
}

extension CompetitionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelect(index: indexPath.row)
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
        presenter?.searchCompetition(country: country)
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
