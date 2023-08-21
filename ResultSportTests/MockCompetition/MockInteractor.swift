//
//  MockInteractor.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 14/08/2023.
//

import Foundation
@testable import ResultSport

class MockInteractor: CompetitionBusinessLogic {
    var didStart = false
    var didFetch = false
    var didNextPage = false
    var didFetchCountry = false

    func start() async {
        didStart = true
    }

    func fetch() async {
        didFetch = true
    }

    func nextPage(id: String) {
        didNextPage = true
    }

    func fetchCountry(id: String) async {
        didFetchCountry = true
    }
}
