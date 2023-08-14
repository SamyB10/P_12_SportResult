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
    //
    func testPresentInterface() {
        let interactor = MockInteractor()
        let presenter = CompetitionPresenter(interactor: interactor)
        let mockDisplay = MockDisplay()
        presenter.inject(display: mockDisplay)

        let exampleResponses: [CompetitionModels.Response] = [
            CompetitionModels.Response(countryId: "c1",
                                       countryName: "Country 1",
                                       leagueId: "l1",
                                       leagueName: "League 1",
                                       leagueSeason: "2023",
                                       leagueLogo: "logo1",
                                       countryLogo: "country_logo1"),
        ]
        presenter.presentInterface(with: exampleResponses)
        XCTAssertTrue(mockDisplay.didDisplayInterface)
    }

    func testPresentLoader() {
        let interactor = MockInteractor()
        let presenter = CompetitionPresenter(interactor: interactor)
        let mockDisplay = MockDisplay()
        presenter.inject(display: mockDisplay)
        presenter.presentLoader()
        XCTAssertTrue(mockDisplay.didDisplayLoader)
    }

    func testPresentError() {
        let interactor = MockInteractor()
        let presenter = CompetitionPresenter(interactor: interactor)
        let mockDisplay = MockDisplay()
        presenter.inject(display: mockDisplay)
        presenter.presentError()
        XCTAssertTrue(mockDisplay.didDisplayLoader)
    }

    func testDidLoad() {
        let mockInteractor = MockInteractor()
        let presenter = CompetitionPresenter(interactor: mockInteractor)

        let expectation = XCTestExpectation(description: "didLoad expectation")
        presenter.didLoad()
        Task {
            XCTAssertTrue(mockInteractor.didStart)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testDidSelect() {
        let mockInteractor = MockInteractor()
        let presenter = CompetitionPresenter(interactor: mockInteractor)
        presenter.didSelect(id: "id")
        XCTAssertTrue(mockInteractor.didNextPage)
    }

    func testSearchCompetition() {
        let mockInteractor = MockInteractor()
        let presenter = CompetitionPresenter(interactor: mockInteractor)

        let exampleResponses: [CompetitionModels.Response] = [
            CompetitionModels.Response(countryId: "c1",
                                       countryName: "England",
                                       leagueId: "l1",
                                       leagueName: "League 1",
                                       leagueSeason: "2023",
                                       leagueLogo: "logo1",
                                       countryLogo: "country_logo1"),
        ]

        let expectation = XCTestExpectation(description: "didLoad expectation")
        presenter.presentInterface(with: exampleResponses)
        presenter.searchCompetition(country: "England")
        Task {
            XCTAssertTrue(mockInteractor.didFetchCountry)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testStart() {
        let mockPresenter = MockPresenter()
        let mockRouter = MockRouter()
        let interactor = CompetitionInteractor(router: mockRouter)
        interactor.inject(presenter: mockPresenter)

        let expectation = XCTestExpectation(description: "start expectation")
        Task {
            await interactor.start()
            XCTAssertTrue(mockPresenter.didPresentInterface)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchCountry() {
        let mockPresenter = MockPresenter()
        let mockRouter = MockRouter()
        let interactor = CompetitionInteractor(router: mockRouter)
        interactor.inject(presenter: mockPresenter)

        let expectation = XCTestExpectation(description: "fetchCountry expectation")
        Task {
            await interactor.fetchCountry(id: "6")
            XCTAssertTrue(mockPresenter.didPresentError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testNextPage() {
        let mockPresenter = MockPresenter()
        let mockRouter = MockRouter()
        let interactor = CompetitionInteractor(router: mockRouter)
        interactor.inject(presenter: mockPresenter)
        interactor.nextPage(id: "3")
        XCTAssertTrue(mockRouter.didNextpage)
    }
}
