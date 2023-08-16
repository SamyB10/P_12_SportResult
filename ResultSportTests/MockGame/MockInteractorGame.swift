//
//  MockInteractor.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 14/08/2023.
//

import Foundation
import ResultSport

class MockInteractorGame: GameBusinessLogic {
    var didStart = false

    func start(from: String, to: String) async {
        didStart = true
    }
}
