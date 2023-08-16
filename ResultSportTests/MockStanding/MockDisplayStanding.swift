//
//  MockDisplay.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 14/08/2023.
//

import Foundation
@testable import ResultSport

class MockDisplayStanding: StandingDisplayLogic {

    var didDisplayInterface = false
    var didDisplayLoader = false
    var didDisplayError = false

    func displayInterface(with viewModel: [StandingModels.ViewModel]) {
        didDisplayInterface = true
    }

    func updateInterface(with viewModel: [StandingModels.ViewModel]) {}
    
    func displayError(with error: Error) {
        didDisplayError = true
    }

    func displayLoader() {
        didDisplayLoader = true
    }
}
