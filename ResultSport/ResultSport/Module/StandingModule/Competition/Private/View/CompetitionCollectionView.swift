//
//  File.swift
//  
//
//  Created by Samy Boussair on 29/07/2023.
//

import UIKit

final class CompetitionCollectionView: UICollectionView {

    private func createLayoutCompetition() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                  heightDimension: .absolute(50))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(65))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 14.0,
                                                        leading: 34.0,
                                                        bottom: 0.0,
                                                        trailing: 0.0)

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical

        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        return layout
    }

    private lazy var cellRegistration: UICollectionView.CellRegistration<CompetitionCell, SportModels.ViewModel> = {
        UICollectionView.CellRegistration<CompetitionCell, SportModels.ViewModel> { [weak self] cell, indexPath, item in
            cell.configure(viewModel: item)
        }
    }()

    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Int, SportModels.ViewModel> = {
        let dataSource = UICollectionViewDiffableDataSource<Int, SportModels.ViewModel>(collectionView: self) {
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

    func snapShot(withViewModel viewModel: [SportModels.ViewModel]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, SportModels.ViewModel>()
        snapShot.appendSections([0])
        snapShot.appendItems(viewModel, toSection: 0)
        DispatchQueue.main.async {
            self.diffableDataSource.apply(snapShot, animatingDifferences: true)
        }
    }

    private func configureCollectionView() {
        _ = cellRegistration
        collectionViewLayout = createLayoutCompetition()
    }
}
