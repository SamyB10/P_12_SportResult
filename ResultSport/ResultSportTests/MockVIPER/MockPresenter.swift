//
//  MockPresenter.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 14/08/2023.
//

import Foundation
@testable import ResultSport

class MockPresenter: CompetitionPresentationLogic {
    var didPresentInterface = false
    var didPresentLoader = false
    var didPresentError = false

    func presentInterface(with response: [CompetitionModels.Response]) {
        didPresentInterface = true
    }

    func presentLoader() {
        didPresentLoader = true
    }

    func presentError() {
        didPresentError = true
    }
}
