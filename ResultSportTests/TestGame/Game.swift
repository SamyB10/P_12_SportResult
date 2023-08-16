//
//  Game.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 14/08/2023.
//

import XCTest
@testable import ResultSport

final class Game: XCTestCase {
    
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
    
    func testPresentInterface() {
        let interactor = MockInteractorGame()
        let presenter = GamePresenter(interactor: interactor)
        let mockDisplay = MockDisplayGame()
        presenter.inject(display: mockDisplay)
        
        let exampleResponses: [GameModels.Response] = [
            GameModels.Response(matchId: "1",
                                countryId: "2",
                                countryName: "3",
                                leagueId: "4",
                                leagueName: "5",
                                matchStatus: "6",
                                matchTime: "7",
                                homeTeamName: "8",
                                homeTeamScore: "9",
                                awayTeamName: "10",
                                awayTeamScore: "11",
                                stadium: "12",
                                homeBadge: "13",
                                awayBadge: "14",
                                leagueLogo: "15")
        ]
        presenter.presentInterface(with: exampleResponses)
        XCTAssertTrue(mockDisplay.didDisplayInterface)
    }
    
    func testPresentLoader() {
        let interactor = MockInteractorGame()
        let presenter = GamePresenter(interactor: interactor)
        let mockDisplay = MockDisplayGame()
        presenter.inject(display: mockDisplay)
        presenter.presentLoader()
        XCTAssertTrue(mockDisplay.didDisplayLoader)
    }
    
    func testPresentError() {
        let interactor = MockInteractorGame()
        let presenter = GamePresenter(interactor: interactor)
        let mockDisplay = MockDisplayGame()
        presenter.inject(display: mockDisplay)
        presenter.presentError(with: NetworkError.failedLoading)
        XCTAssertTrue(mockDisplay.didDisplayError)
    }
    
    func testFetchGame() {
        let mockInteractor = MockInteractorGame()
        let presenter = GamePresenter(interactor: mockInteractor)
        
        let expectation = XCTestExpectation(description: "didLoad expectation")
        presenter.fetchGame(from: "2-10-2023", to: "2-10-2023")
        Task {
            XCTAssertTrue(mockInteractor.didStart)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testDidSelectItem() {
        let mockInteractor = MockInteractorGame()
        let presenter = GamePresenter(interactor: mockInteractor)
        let mockDisplay = MockDisplayGame()
        presenter.inject(display: mockDisplay)

        let expectation = XCTestExpectation(description: "didLoad expectation")
        presenter.didLoad()
        presenter.didSelectItem(indexPath: 2)
        Task {
            XCTAssertTrue(mockDisplay.didDisplayInterface)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testDidSelectLeague() {
        let mockInteractor = MockInteractorGame()
        let presenter = GamePresenter(interactor: mockInteractor)
        let mockDisplay = MockDisplayGame()
        presenter.inject(display: mockDisplay)

        let expectation = XCTestExpectation(description: "didLoad expectation")
        presenter.didLoad()
        presenter.didSelectLeague(id: "152")
        Task {
            XCTAssertTrue(mockDisplay.didDisplayInterface)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testLoader() {
        let mockInteractor = MockInteractorGame()
        let presenter = GamePresenter(interactor: mockInteractor)
        let mockDisplay = MockDisplayGame()
        presenter.inject(display: mockDisplay)
        presenter.presentLoader()
        XCTAssertTrue(mockDisplay.didDisplayLoader)
    }

    func testError() {
        let mockInteractor = MockInteractorGame()
        let presenter = GamePresenter(interactor: mockInteractor)
        let mockDisplay = MockDisplayGame()
        presenter.inject(display: mockDisplay)
        presenter.presentError(with: NetworkError.failedLoading)
        XCTAssertTrue(mockDisplay.didDisplayError)
    }
}
