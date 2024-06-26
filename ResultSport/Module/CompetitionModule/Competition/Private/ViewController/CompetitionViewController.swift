//
//  CompetitionViewController.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import UIKit

class CompetitionViewController: UIViewController {

    // MARK: - Property
    private var presenter: CompetitionInteractionLogic?
    private var viewModel: [CompetitionModels.ViewModel]? {
        didSet {
            guard let viewModel, viewModel != oldValue else { return }
            competitionCollectionView.snapShot(withViewModel: viewModel)
        }
    }

    // MARK: - Subviews
    private lazy var competitionCollectionView: CompetitionCollectionView = {
        let collectionView = CompetitionCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private lazy var bottomTextField: UIView = {
        let barreSearch = UIView()
        barreSearch.translatesAutoresizingMaskIntoConstraints = false
        barreSearch.backgroundColor = .systemGray
        return barreSearch
    }()

    private var textField: UITextField = {
        let textField = UITextField()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.systemGray ]
        textField.accessibilityLabel = "Country ?"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Germany, England, French...",
                                                             attributes: placeholderAttributes)
        return textField
    }()

    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
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
        setupInterface()
        setupConstraints()
        presenter?.didLoad()
        activityIndicatorStart()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let gradientLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer.frame = CGRect(origin: .zero, size: size)
        }
    }

    private func setupInterface() {
        view.addSubview(competitionCollectionView)
        view.addSubview(textField)
        competitionCollectionView.addSubview(activityIndicator)
        view.addSubview(bottomTextField)
        textField.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.trailingAnchor .constraint(equalTo: view.trailingAnchor, constant: -25),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textField.bottomAnchor.constraint(equalTo: competitionCollectionView.topAnchor, constant: -20),

            competitionCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            competitionCollectionView.trailingAnchor .constraint(equalTo: view.trailingAnchor),
            competitionCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            competitionCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: competitionCollectionView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: competitionCollectionView.centerYAnchor),

            bottomTextField.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            bottomTextField.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            bottomTextField.topAnchor.constraint(equalTo: textField.bottomAnchor),
            bottomTextField.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    func inject(presenter: CompetitionInteractionLogic) {
        self.presenter = presenter
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

    private func alertController(error: String) {
        let alertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        Task {
            present(alertController, animated: true, completion: nil)
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
        guard let text = textField.text else { return false }
        guard let error = presenter?.textFieldGood(country: text) else {
            textField.resignFirstResponder()
            return true
        }
        alertController(error: error.rawValue)
        return false
    }
}

extension CompetitionViewController: CompetitionDisplayLogic {
    func displayInterface(with viewModel: [CompetitionModels.ViewModel]) {
        activityIndicatorEnd()
        updateInterface(with: viewModel)
    }
    
    func updateInterface(with viewModel: [CompetitionModels.ViewModel]) {
        self.viewModel = viewModel
    }

    func displayError(with error: Error) {
        activityIndicatorEnd()
        alertController(error: error.localizedDescription)
    }

    func displayLoader() {
        activityIndicatorStart()
    }
}
