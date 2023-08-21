//
//  ResultSportTests.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 04/08/2023.
//

import XCTest
@testable import ResultSport

final class ResultSportTests: XCTestCase {

    override func setUpWithError() throws {
        if let jsonData = MockURLProtocol.loadJSONData(filename: "MockGame") {
            let url = "https://apiv3.apifootball.com/?action=get_events&from=2023-04-05&to=2023-04-05&APIkey=\(Key.apiKey)"
            MockURLProtocol.mockData[url] = jsonData
        }
        URLProtocol.registerClass(MockURLProtocol.self)
    }

    override func tearDownWithError() throws {
        URLProtocol.unregisterClass(MockURLProtocol.self)
    }

    func testApiGameOk() async {
        let request = HttpRequest()

        if let jsonData = MockURLProtocol.loadJSONData(filename: "MockGame") {
            let url = "https://apiv3.apifootball.com/?action=get_events&from=2023-04-05&to=2023-04-05&APIkey=\(Key.apiKey)"
            MockURLProtocol.mockData[url] = jsonData
            let expectation = XCTestExpectation(description: "Network request")
            let result = await request.fetchSchedule(from: "2023-04-05", to: "2023-04-05")

            switch result {
            case .success(let decodedResponse):
                XCTAssertNotNil(decodedResponse)
                XCTAssertEqual(decodedResponse.count, 2)
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
