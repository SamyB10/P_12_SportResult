//
//  MockInteractor.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 14/08/2023.
//

import Foundation
import ResultSport

class MockInteractorStanding: StandingBusinessLogic {
    var didFetch = false

    func start(leagueId: String) async {
        didFetch = true
    }
}
