//
//  MockDisplay.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 14/08/2023.
//

import Foundation
@testable import ResultSport

class MockDisplay: CompetitionDisplayLogic {
    var didDisplayInterface = false
    var didDisplayLoader = false
    var didDisplayError = false

    func displayInterface(with viewModel: [ResultSport.CompetitionModels.ViewModel]) {
        didDisplayInterface = true
    }

    func updateInterface(with viewModel: [ResultSport.CompetitionModels.ViewModel]) {}

    func displayError(with error: Error) {
        didDisplayError = true
    }

    func displayLoader() {
        didDisplayLoader = true
    }
}
