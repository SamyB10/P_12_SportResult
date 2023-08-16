//
//  MockDisplay.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 14/08/2023.
//

import Foundation
@testable import ResultSport

class MockDisplayGame: GameDisplayLogic {
    var didDisplayInterface = false
    var didDisplayLoader = false
    var didDisplayError = false

    func displayInterface(with viewModel: [GameModels.ViewModel]) {
        didDisplayInterface = true
    }

    func updateInterface(with viewModel: [GameModels.ViewModel]) {}

    func displayInterfaceGame(with viewModel: GameModels.ViewModel.Championship) {
        didDisplayInterface = true
    }

    func updateInterfaceGame(with viewModel: [GameModels.ViewModel.Game]) {}
    
    func displayError(with error: Error) {
        didDisplayError = true
    }

    func displayLoader() {
        didDisplayLoader = true
    }
}
