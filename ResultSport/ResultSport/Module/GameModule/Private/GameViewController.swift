//
//  GameViewController.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import UIKit

class GameViewController: UIViewController {

    private var presenter: GameInteractionLogic?
    private let viewModelPicker = GameModels.ViewModel.ViewModelPicker()
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

    private lazy var pickerLeague: UIPickerView = {
        let pickerLeague = UIPickerView()
        pickerLeague.translatesAutoresizingMaskIntoConstraints = false
        pickerLeague.backgroundColor = .clear
        pickerLeague.delegate = self
        pickerLeague.dataSource = self
        pickerLeague.isHidden = true
        pickerLeague.backgroundColor = .white
        return pickerLeague
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.mainColorTest.cgColor,
            UIColor.cellColorTest.cgColor,
        ]
        view.layer.addSublayer(gradientLayer)
        let pickerButton = UIBarButtonItem(image: UIImage(systemName: "text.justify"),
                                           style: .done,
                                           target: self,
                                           action: #selector(displayPickerLeague))
        self.navigationItem.rightBarButtonItem = pickerButton
        setupInterface()
        setupConstraints()
        presenter?.didLoad()
    }

    private func setupInterface() {
        view.addSubview(dateCollectionView)
        view.addSubview(separatorView)
        view.addSubview(gameCollectionView)
        view.addSubview(pickerLeague)
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

            pickerLeague.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerLeague.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickerLeague.heightAnchor.constraint(equalToConstant: 200),
            pickerLeague.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pickerLeague.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        ])
    }

    func inject(presenter: GameInteractionLogic) {
        self.presenter = presenter
    }

    @objc func displayPickerLeague() {
        pickerLeague.isHidden = false
    }
}

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(indexPath: indexPath.row)
    }
}

extension GameViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModelPicker.leagues.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let leagues = Array(viewModelPicker.leagues.keys)
        self.pickerLeague.isHidden = true
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let leagues = Array(viewModelPicker.leagues.values)
        return leagues[row]
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
        self.viewModelGame = viewModel.word
    }

    func updateInterfaceGame(with viewModel: [GameModels.ViewModel.Game]) {
        self.viewModelGame = viewModel
    }

    func displayError(with error: Error) {}

    func displayLoader() {}
}
