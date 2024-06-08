//
//  CollectionViewLineup.swift
//  ResultSport
//
//  Created by Samy Boussair on 04/09/2023.
//

import UIKit

final class CollectionViewLineup: UICollectionView {

    private var viewModel: [GameDetailsModels.ViewModel]? {
        didSet {
            guard let viewModelHome = viewModel?.first?.home else { return }
            snapShot(withViewModel: viewModelHome)
        }
    }

    private var viewModelLineup: [GameDetailsModels.ViewModel.LineupTeam]? {
        didSet {
            guard let viewModelLineup = viewModelLineup else { return }
            snapShot(withViewModel: viewModelLineup)
        }
    }

    private func createLayoutGame() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(35))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(37))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical

        let layout = UICollectionViewCompositionalLayout(section: section,
                                                         configuration: config)
        return layout
    }


    private lazy var cellRegistration: UICollectionView.CellRegistration<CellLineup, GameDetailsModels.ViewModel.LineupTeam> = {
        UICollectionView.CellRegistration<CellLineup, GameDetailsModels.ViewModel.LineupTeam> { [weak self] cell, indexPath, item in
            cell.configure(viewModel: item)
        }
    }()

    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Int, GameDetailsModels.ViewModel.LineupTeam> = {
        let dataSource = UICollectionViewDiffableDataSource<Int, GameDetailsModels.ViewModel.LineupTeam>(collectionView: self) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            return cell
        }
        return dataSource
    }()

    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        configureCollectionView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func snapShot(withViewModel viewModel: [GameDetailsModels.ViewModel.LineupTeam]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, GameDetailsModels.ViewModel.LineupTeam>()
        snapShot.appendSections([0])
        snapShot.appendItems(viewModel, toSection: 0)
        DispatchQueue.main.async {
            self.diffableDataSource.apply(snapShot, animatingDifferences: true)
        }
    }

    private func configureCollectionView() {
        collectionViewLayout = createLayoutGame()
        _ = cellRegistration
    }

    func inject(viewModel: [GameDetailsModels.ViewModel]) {
        self.viewModel = viewModel
    }

    func injectLineup(viewModel: [GameDetailsModels.ViewModel.LineupTeam]) {
        self.viewModelLineup = viewModel
    }
}
