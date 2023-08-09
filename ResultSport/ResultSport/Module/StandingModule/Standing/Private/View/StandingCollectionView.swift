//
//  StandingCollectionView.swift
//  ResultSport
//
//  Created by Samy Boussair on 07/08/2023.
//

import UIKit

class StandingCollectionView: UICollectionView {
    private func createLayoutStanding() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(50))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(50))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical

        let layout = UICollectionViewCompositionalLayout(section: section,
                                                         configuration: config)
        return layout
    }

    private lazy var cellRegistration: UICollectionView.CellRegistration<StandingCell, StandingModels.ViewModel> = {
        UICollectionView.CellRegistration<StandingCell, StandingModels.ViewModel> { [weak self] cell, indexPath, item in
            cell.configure(viewModel: item)
        }
    }()

    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Int, StandingModels.ViewModel> = {
        let dataSource = UICollectionViewDiffableDataSource<Int, StandingModels.ViewModel>(collectionView: self) {
            collectionView, indexPath, itemIdentifier in
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

    func snapShot(with viewModel: [StandingModels.ViewModel]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, StandingModels.ViewModel>()
        snapShot.appendSections([0])
        snapShot.appendItems(viewModel, toSection: 0)
        DispatchQueue.main.async {
            self.diffableDataSource.apply(snapShot, animatingDifferences: true)
        }
    }

    private func configureCollectionView() {
        _ = cellRegistration
        collectionViewLayout = createLayoutStanding()
    }
}
