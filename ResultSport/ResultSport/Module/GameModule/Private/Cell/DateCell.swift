//
//  File.swift
//  
//
//  Created by Samy Boussair on 01/08/2023.
//

import UIKit

class DateCell: UICollectionViewCell {

    // MARK: - Subviews

    private lazy var day: UILabel = {
        let day = UILabel()
        day.textAlignment = .center
        day.font = .systemFont(ofSize: 14, weight: .bold)
//        day.font = .italicSystemFont(ofSize: 14)
        day.textColor = .white
        day.textAlignment = .center
        day.translatesAutoresizingMaskIntoConstraints = false
        return day
    }()

    private lazy var dayNumber: UILabel = {
        let dayNumber = UILabel()
        dayNumber.textAlignment = .center
        dayNumber.font = .systemFont(ofSize: 9, weight: .bold)
        dayNumber.textColor = .white
        dayNumber.textAlignment = .center
        dayNumber.translatesAutoresizingMaskIntoConstraints = false
        return dayNumber
    }()

    private var viewModel: GameModels.ViewModel? {
        didSet {
            guard let viewModel, viewModel != oldValue else { return }
            updateInterface()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
        setUpConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func setupInterface() {
        contentView.addSubview(day)
        contentView.addSubview(dayNumber)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            day.topAnchor.constraint(equalTo: contentView.topAnchor),
            day.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            day.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            day.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),

            dayNumber.topAnchor.constraint(equalTo: day.bottomAnchor),
            dayNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dayNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dayNumber.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    private func updateInterface() {
        formaterDate()
        updateColor()
    }

    private func formaterDate() {
        guard let viewModel = viewModel else { return }
        day.text = viewModel.day

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = dateFormatter.date(from: viewModel.dayNumber) else {
            dayNumber.text = viewModel.dayNumber
            return
        }

        dateFormatter.dateFormat = "dd-MM"
        let formattedDate = dateFormatter.string(from: date)
        dayNumber.text = formattedDate
    }
    
    private func updateColor() {
        guard let viewModel = viewModel else { return }
        guard viewModel.isActive else {
            day.textColor = UIColor.white.withAlphaComponent(0.5)
            dayNumber.textColor = UIColor.white.withAlphaComponent(0.5)
            return
        }
        day.textColor = .white
        dayNumber.textColor = .white
    }

    func configure(viewModel: GameModels.ViewModel) {
        self.viewModel = viewModel
    }
}
