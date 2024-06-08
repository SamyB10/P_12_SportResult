//
//  LineupSegmented.swift
//  ResultSport
//
//  Created by Samy Boussair on 05/09/2023.

import UIKit

final class LineupSegmented: UISegmentedControl {

    init() {
        super.init(frame: .zero)
        configSegementedControl()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func configSegementedControl() {
        self.insertSegment(withTitle: "HOME", at: 0, animated: false)
        self.insertSegment(withTitle: "AWAY", at: 1, animated: false)
        self.insertSegment(withTitle: "OTHER", at: 2, animated: false)

        
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.setTitleTextAttributes(normalTextAttributes, for: .normal)

        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        self.setTitleTextAttributes(selectedTextAttributes, for: .selected)
    }
}
