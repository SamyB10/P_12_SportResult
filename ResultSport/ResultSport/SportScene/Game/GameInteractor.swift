//
//  Interactor.swift
//  Sport
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
//import GameModuleKit

class GameInteractor {

    private weak var presenter: GamePresenter?
    private var router: GameRoutingLogic?
    private let request = HttpRequest()

    private var contextGame = GameContext() {
        didSet {
            guard contextGame != oldValue else { return }
            switch (contextGame.gameContext, contextGame.didFailLoading) {
            case (_, true):
                self.presenter?.presentError()
            case (.none, false):
                self.presenter?.presentLoader()
            case (.some(let gameContent), false):
                self.presenteResponseGame(with: gameContent)
            }
        }
    }

    init(router: GameRoutingLogic) {
        self.router = router
    }

    func inject(presenter: GamePresenter) {
        self.presenter = presenter
    }

    private func fetchGame(from: String, to: String) async {
//        let test = "2023-03-05"
//        contextGame.willLoadContent()
//        switch await request.fetchSchedule(from: test, to: test) {
//        case .success(let game):
//            contextGame.gameContext = game
//        case .failure:
//            contextGame.didFailLoading = true
//        }

        // MARK: Simulate response
        let game = await simulateFetchingGame()
        presenteResponseGame(with: game)
    }

    private func simulateFetchingGame() async -> [RestSchedule] {
        var games: [RestSchedule] = []

        for i in 0...10 {
            let countryId = "\(i)"
            let countryName = "Pays \(i)"
            let leagueId = "\(i)"
            let leagueName = "Ligue \(i)"
            let leagueLogo = "logo\(i)"

            let game = RestSchedule(matchId: "matchId_\(i)",
                                    countryId: countryId,
                                    countryName: countryName,
                                    leagueId: leagueId,
                                    leagueName: leagueName,
                                    matchStatus: "Match Status \(i)",
                                    matchTime: "Match Time \(i)",
                                    homeTeamName: "Manchester city \(i)",
                                    homeTeamScore: "\(i)",
                                    awayTeamName: "Away Team \(i)",
                                    awayTeamScore: "\(i)",
                                    stadium: "Stadium \(i)",
                                    homeBadge: "Home Badge \(i)",
                                    awayBadge: "Away Badge \(i)",
                                    leagueLogo: leagueLogo)
            games.append(game)
        }
        return games
    }

    private func presenteResponseGame(with game: [RestSchedule]) {
        let response = mapGame(with: game)
        presenter?.presentInterface(with: response)
    }

    private func mapGame(with game: [RestSchedule]) -> [GameModels.Response] {
        return game.compactMap { game in
//            guard let matchId = game.matchId,
//                  let countryId = game.countryId,
//                  let countryName = game.countryName,
//                  let leagueId = game.leagueId,
//                  let leagueName = game.leagueName,
//                  let matchStatus = game.matchStatus,
//                  let matchTime = game.matchTime,
//                  let homeTeamName = game.homeTeamName,
//                  let homeTeamScore = game.homeTeamScore,
//                  let awayTeamName = game.awayTeamName,
//                  let awayTeamScore = game.awayTeamScore,
//                  let stadium = game.stadium,
//                  let homeBadge = game.homeBadge,
//                  let awayBadge = game.awayBadge,
//                  let leagueLogo = game.leagueLogo else { return nil }

            return GameModels.Response(matchId: game.matchId,
                                       countryId: game.countryId,
                                       countryName: game.countryName,
                                       leagueId: game.leagueId,
                                       leagueName: game.leagueName,
                                       matchStatus: game.matchStatus,
                                       matchTime: game.matchTime,
                                       homeTeamName: game.homeTeamName,
                                       homeTeamScore: game.homeTeamScore,
                                       awayTeamName: game.awayTeamName,
                                       awayTeamScore: game.awayTeamScore,
                                       stadium: game.stadium,
                                       homeBadge: game.homeBadge,
                                       awayBadge: game.awayBadge,
                                       leagueLogo: game.leagueLogo)
        }
    }
}

extension GameInteractor: GameBusinessLogic {

    func start(from: String, to: String) async {
        await fetchGame(from: from, to: to)
    }

    func fetch() async {}
}
