//
//  TestCompetitions.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 12/08/2023.
//

import XCTest
@testable import ResultSport

final class TestCompetitionsApi: XCTestCase {

    override func setUpWithError() throws {
        if let jsonData = MockURLProtocol.loadJSONData(filename: "MockLeague") {
            let url = "https://apiv3.apifootball.com/?action=get_leagues&APIkey=\(Key.apiKey)"
            MockURLProtocol.mockData[url] = jsonData
        }
        URLProtocol.registerClass(MockURLProtocol.self)
    }

    override func tearDownWithError() throws {
        URLProtocol.unregisterClass(MockURLProtocol.self)
    }

    func testApiGameOk() async {
        let request = HttpRequest()

        if let jsonData = MockURLProtocol.loadJSONData(filename: "MockLeague") {
            let url = "https://apiv3.apifootball.com/?action=get_leagues&APIkey=\(Key.apiKey)"
            MockURLProtocol.mockData[url] = jsonData
            let expectation = XCTestExpectation(description: "Network request")
            let result = await request.fetchCountryAndLeague()

            switch result {
            case .success(let decodedResponse):
                XCTAssertNotNil(decodedResponse)
                XCTAssertEqual(decodedResponse.count, 88)
                expectation.fulfill()
            case .failure(let error):
                print("Error during decoding: \(error.localizedDescription)")
                XCTFail("Erreur requête : \(error)")
                expectation.fulfill()
            }
        } else {
            XCTFail("Failed to load mock JSON file")
        }
    }
}
