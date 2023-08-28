//
//  matchStatusSegmented.swift
//  ResultSport
//
//  Created by Samy Boussair on 28/08/2023.
//

import Foundation
import UIKit

final class MatchStatusSegmented: UISegmentedControl {

    init() {
        super.init(frame: .zero)
        configSegementedControl()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private func configSegementedControl() {
        self.insertSegment(withTitle: "SCHEDULE", at: 0, animated: false)
        self.insertSegment(withTitle: "LIVE", at: 1, animated: false)

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
