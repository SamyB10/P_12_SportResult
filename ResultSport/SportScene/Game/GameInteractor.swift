//
//  GameInteractor.swift
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

class GameInteractor {

    private weak var presenter: GamePresentationLogic?
    private var router: GameRoutingLogic?
    private let request = HttpRequest()

    private var contextGame = GameContext() {
        didSet {
            guard contextGame != oldValue else { return }
            switch (contextGame.gameContext, contextGame.didFailLoading) {
            case (_, true):
                let error = NetworkError.failedLoading
                self.presenter?.presentError(with: error)
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

    func inject(presenter: GamePresentationLogic) {
        self.presenter = presenter
    }

    private func fetch(from: String, to: String) async {
        contextGame.willLoadContent()
        switch await request.fetchSchedule(from: from, to: to) {
        case .success(let game):
            contextGame.gameContext = game
        case .failure:
            contextGame.didFailLoading = true
        }
    }

    private func presenteResponseGame(with game: [RestSchedule]) {
        let response = mapGame(with: game)
        presenter?.presentInterface(with: response)
    }

    private func mapGame(with game: [RestSchedule]) -> [GameModels.Response] {
        return game.compactMap { game in
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
        await fetch(from: from, to: to)
    }
}
