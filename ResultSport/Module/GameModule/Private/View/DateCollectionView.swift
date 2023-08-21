//
//  File.swift
//  
//
//  Created by Samy Boussair on 01/08/2023.
//

import UIKit

final class DateCollectionView: UICollectionView {

    private func createLayoutDate() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                               heightDimension: .absolute(50))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal

        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        return layout
    }

    private lazy var cellRegistration: UICollectionView.CellRegistration<DateCell, GameModels.ViewModel> = {
        UICollectionView.CellRegistration<DateCell, GameModels.ViewModel> { [weak self] cell, indexPath, item in
            cell.configure(viewModel: item)
        }
    }()

    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Int, GameModels.ViewModel> = {
        let dataSource = UICollectionViewDiffableDataSource<Int, GameModels.ViewModel>(collectionView: self) {
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

    func snapShot(withViewModel viewModel: [GameModels.ViewModel]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, GameModels.ViewModel>()
        snapShot.appendSections([0])
        snapShot.appendItems(viewModel, toSection: 0)
        DispatchQueue.main.async {
            self.diffableDataSource.apply(snapShot, animatingDifferences: true)
        }
    }

    private func configureCollectionView() {
        _ = cellRegistration
        collectionViewLayout = createLayoutDate()
    }
}
