//
//  GameCollectionView.swift
//  
//
//  Created by Samy Boussair on 02/08/2023.
//

import UIKit

final class GameCollectionView: UICollectionView {

    private var viewModel: [GameModels.ViewModel.Game]? {
        didSet {
            guard let viewModel, viewModel != oldValue else { return }
            snapShot(withViewModel: viewModel)
        }
    }

    private func createLayoutGame() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                              heightDimension: .absolute(150))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(160))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 14.0,
                                                        leading: 20.0,
                                                        bottom: 0.0,
                                                        trailing: 0.0)

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical

        let layout = UICollectionViewCompositionalLayout(section: section,
                                                         configuration: config)
        return layout
    }

    private lazy var cellRegistration: UICollectionView.CellRegistration<GameCell, GameModels.ViewModel.Game> = {
        UICollectionView.CellRegistration<GameCell, GameModels.ViewModel.Game> { [weak self] cell, indexPath, item in
               cell.configure(viewModel: item)
           }
       }()

    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Int, GameModels.ViewModel.Game> = {
        let dataSource = UICollectionViewDiffableDataSource<Int, GameModels.ViewModel.Game>(collectionView: self) { collectionView, indexPath, itemIdentifier in
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

    private func snapShot(withViewModel viewModel: [GameModels.ViewModel.Game]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, GameModels.ViewModel.Game>()
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

    func inject(viewModel: [GameModels.ViewModel.Game]) {
        self.viewModel = viewModel
    }
}
