//
//  MockRouteur.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 14/08/2023.
//

import Foundation
@testable import ResultSport

class MockRouter: CompetitionRoutingLogic {
    var didNextpage = false
    func routeToNextPage(id: String) {
        didNextpage = true
    }
}
