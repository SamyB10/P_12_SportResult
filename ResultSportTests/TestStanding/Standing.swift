//
//  TestStanding.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 15/08/2023.
//

import XCTest
@testable import ResultSport

final class Standing: XCTestCase {

    override func setUpWithError() throws {
        if let jsonData = MockURLProtocol.loadJSONData(filename: "MockStanding") {
            let url = "https://apiv3.apifootball.com/?action=get_standings&league_id=152&APIkey=\(Key.apiKey)"
            MockURLProtocol.mockData[url] = jsonData
        }
        URLProtocol.registerClass(MockURLProtocol.self)
    }

    override func tearDownWithError() throws {
        URLProtocol.unregisterClass(MockURLProtocol.self)
    }

    func testApiLeagueOk() async {
        let request = HttpRequest()

        if let jsonData = MockURLProtocol.loadJSONData(filename: "MockStanding") {
            let url = "https://apiv3.apifootball.com/?action=get_standings&league_id=152&APIkey=\(Key.apiKey)"
            MockURLProtocol.mockData[url] = jsonData
            let expectation = XCTestExpectation(description: "Network request")
            let result = await request.fetchStanding(leagueId: "152")

            switch result {
            case .success(let decodedResponse):
                XCTAssertNotNil(decodedResponse)
                XCTAssertEqual(decodedResponse.count, 20)
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

    func testPresentInterface() {
        let interactor = MockInteractorStanding()
        let presenter = StandingPresenter(interactor: interactor)
        let mockDisplay = MockDisplayStanding()
        presenter.inject(display: mockDisplay)

        let exampleResponses: [StandingModels.Response] = [
            StandingModels.Response(countryName: "1",
                                    leagueName: "2",
                                    teamId: "3",
                                    teamName: "4",
                                    teamLogo: "5",
                                    promotion: "11",
                                    leaguePosition: "22",
                                    leaguePlayed: "33",
                                    gameWin: "44",
                                    gameNul: "123",
                                    gameLose: "121",
                                    standingPts: "12321")
        ]
        presenter.presentInterface(with: exampleResponses)
        XCTAssertTrue(mockDisplay.didDisplayInterface)
    }

    func testPresentLoader() {
        let interactor = MockInteractorStanding()
        let presenter = StandingPresenter(interactor: interactor)
        let mockDisplay = MockDisplayStanding()
        presenter.inject(display: mockDisplay)
        presenter.presentLoader()
        XCTAssertTrue(mockDisplay.didDisplayLoader)
    }

    func testPresentError() {
        let interactor = MockInteractorStanding()
        let presenter = StandingPresenter(interactor: interactor)
        let mockDisplay = MockDisplayStanding()
        presenter.inject(display: mockDisplay)

        presenter.presentError(with: NetworkError.failedLoading)
        XCTAssertTrue(mockDisplay.didDisplayError)
    }

    func testDidFetchLeague() {
        let mockInteractor = MockInteractorStanding()
        let presenter = StandingPresenter(interactor: mockInteractor)

        let expectation = XCTestExpectation(description: "didLoad expectation")
        presenter.didFetchLeague(leagueId: "6")
        Task {
            XCTAssertTrue(mockInteractor.didFetch)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testStart() {
        let mockPresenter = MockPresenterStanding()
        let mockRouter = MockRouterStanding()
        let interactor = StandingInteractor(router: mockRouter)
        interactor.inject(presenter: mockPresenter)

        let expectation = XCTestExpectation(description: "start expectation")
        Task {
            await interactor.start(leagueId: "152")
            XCTAssertTrue(mockPresenter.didPresentInterface)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    
}
