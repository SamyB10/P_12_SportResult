//
//  GameViewController.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import UIKit

class GameViewController: UIViewController {

    let viewModelPicker = GameModels.ViewModel.ViewModelPicker()
    private var presenter: GameInteractionLogic?
    private var viewModel: [GameModels.ViewModel]? {
        didSet {
            guard let viewModel, viewModel != oldValue else { return }
            dateCollectionView.snapShot(withViewModel: viewModel)
            viewModel.forEach {
                if $0.isActive == true {
                    presenter?.fetchGame(from: $0.dayNumber, to: $0.dayNumber)
                }
            }
        }
    }

    private var viewModelGame: [GameModels.ViewModel.Game]? {
        didSet {
            guard let viewModelGame, viewModelGame != oldValue else { return }
            gameCollectionView.inject(viewModel: viewModelGame)
        }
    }

    private lazy var dateCollectionView: DateCollectionView = {
        let date = DateCollectionView()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.backgroundColor = .clear
        date.showsHorizontalScrollIndicator = false
        date.delegate = self

        return date
    }()

    private lazy var gameCollectionView: GameCollectionView = {
        let game = GameCollectionView()
        game.translatesAutoresizingMaskIntoConstraints = false
        game.backgroundColor = .clear
        return game
    }()

    private lazy var separatorView: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .white
        return separator
    }()


    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private lazy var pickerLeague: UIPickerView = {
        let pickerLeague = UIPickerView()
        pickerLeague.translatesAutoresizingMaskIntoConstraints = false
        pickerLeague.backgroundColor = .mainColor
        pickerLeague.delegate = self
        pickerLeague.dataSource = self
        pickerLeague.isHidden = true
        return pickerLeague
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
        let pickerButton = UIBarButtonItem(image: UIImage(systemName: "text.justify"),
                                           style: .done,
                                           target: self,
                                           action: #selector(displayPickerLeague))
        self.navigationItem.rightBarButtonItem = pickerButton
        setupInterface()
        setupConstraints()
        activityIndicatorStart()
        presenter?.didLoad()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let gradientLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer.frame = CGRect(origin: .zero, size: size)
        }
    }

    private func setupInterface() {
        view.addSubview(dateCollectionView)
        view.addSubview(separatorView)
        view.addSubview(gameCollectionView)
        view.addSubview(pickerLeague)
        gameCollectionView.addSubview(activityIndicator)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dateCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dateCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateCollectionView.heightAnchor.constraint(equalToConstant: 50),

            separatorView.topAnchor.constraint(equalTo: dateCollectionView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: dateCollectionView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: dateCollectionView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2),

            gameCollectionView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            gameCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            pickerLeague.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pickerLeague.heightAnchor.constraint(equalToConstant: 200),
            pickerLeague.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerLeague.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: gameCollectionView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: gameCollectionView.centerYAnchor),
        ])
    }

    func inject(presenter: GameInteractionLogic) {
        self.presenter = presenter
    }

    @objc func displayPickerLeague() {
        pickerLeague.isHidden = false
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

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(indexPath: indexPath.row)
        activityIndicatorStart()
    }
}


extension GameViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModelPicker.leagues.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let leagues = Array(viewModelPicker.leagues.values)
        return leagues[row]
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let leagues = Array(viewModelPicker.leagues.values)

        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }

        let title = leagues[row]
        label.text = title
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        label.textColor = .white
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let leagues = Array(viewModelPicker.leagues.keys)
        presenter?.didSelectLeague(id: leagues[row])
        self.pickerLeague.isHidden = true
    }
}

extension GameViewController: GameDisplayLogic {
    func displayInterface(with viewModel: [GameModels.ViewModel]) {
        updateInterface(with: viewModel)
    }

    func updateInterface(with viewModel: [GameModels.ViewModel]) {
        self.viewModel = viewModel
    }

    func displayInterfaceGame(with viewModel: GameModels.ViewModel.Championship) {
        self.activityIndicatorEnd()
        self.viewModelGame = viewModel.word
    }

    func updateInterfaceGame(with viewModel: [GameModels.ViewModel.Game]) {
        guard viewModel.isEmpty else {
            self.viewModelGame = viewModel
            return
        }
        alertController(error: "No games for this championship")
    }

    func displayError(with error: Error) {
        self.activityIndicatorEnd()
        alertController(error: error.localizedDescription)
    }

    func displayLoader() {
        activityIndicatorStart()
    }
}
