//
//  MockPresenter.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 14/08/2023.
//

import Foundation
@testable import ResultSport

class MockPresenterStanding: StandingPresentationLogic {

    var didPresentInterface = false
    var didPresentLoader = false
    var didPresentError = false

    func presentInterface(with response: [StandingModels.Response]) {
        didPresentInterface = true
    }

    func presentLoader() {
        didPresentLoader = true
    }

    func presentError(with error: Error) {
        didPresentError = true
    }
}
