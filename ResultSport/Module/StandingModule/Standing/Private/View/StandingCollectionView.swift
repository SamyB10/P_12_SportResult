//
//  StandingCollectionView.swift
//  ResultSport
//
//  Created by Samy Boussair on 07/08/2023.
//

import UIKit

class StandingCollectionView: UICollectionView {
    private var viewModel: [StandingModels.ViewModel]?
    private func createLayoutStanding() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(50))

        let headerItemSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension,
                                                    heightDimension: .absolute(30))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .topLeading)

        headerItem.pinToVisibleBounds = true

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(50))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [headerItem]
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        

        let layout = UICollectionViewCompositionalLayout(section: section,
                                                         configuration: config)
        return layout
    }

    private lazy var headerRegistration: UICollectionView.SupplementaryRegistration<HeaderCell> = {
        UICollectionView.SupplementaryRegistration<HeaderCell>(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] headerView, elementKind, indexPath in
            guard let viewModel = self?.viewModel?.first else { return }
            headerView.configure(viewModel: viewModel)
        }
    }()
    
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

        dataSource.supplementaryViewProvider = { view, kind, index in
            let headerCell = self.dequeueConfiguredReusableSupplementary(using: self.headerRegistration,
                                                                         for: index)
            return headerCell
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
        self.viewModel = viewModel
        var snapShot = NSDiffableDataSourceSnapshot<Int, StandingModels.ViewModel>()
        snapShot.appendSections([0])
        snapShot.appendItems(viewModel, toSection: 0)
        DispatchQueue.main.async {
            self.diffableDataSource.apply(snapShot, animatingDifferences: true)
        }
    }

    private func configureCollectionView() {
        _ = cellRegistration
        _ = headerRegistration
        collectionViewLayout = createLayoutStanding()
    }
}
