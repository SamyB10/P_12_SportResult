//
//  GameDetailsInteractor.swift
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

class GameDetailsInteractor {

    private weak var presenter: GameDetailsPresentationLogic?
    private var router: GameDetailsRoutingLogic?
    private let request = HttpRequest()

    private var contextGameDetails = GameDetailsContext() {
        didSet {
            guard contextGameDetails != oldValue else { return }
            switch (contextGameDetails.gameDetailsContext, contextGameDetails.didFailLoading) {
            case (_, true):
                let error = NetworkError.failedLoading
                self.presenter?.presentError(with: error)
            case (.none, false):
                self.presenter?.presentLoader()
            case (.some(let GameDetailsContent), false):
                self.presenteResponse(with: GameDetailsContent)
            }
        }
    }

    init(router: GameDetailsRoutingLogic) {
        self.router = router
    }

    func inject(presenter: GameDetailsPresentationLogic) {
        self.presenter = presenter
    }

    private func fetchGame(game: String) async {
        contextGameDetails.willLoadContent()
        switch await request.fetchGame(gameId: game) {
        case .success(let detailsGame):
            contextGameDetails.gameDetailsContext = detailsGame
//            await playerImage(with: detailsGame)
        case .failure:
            contextGameDetails.didFailLoading = true
        }
    }

    private func playerImage(with responseGame: [RestDatailsGame]) async {
        var detailGame = responseGame
        guard responseGame.first?.lineup.home.startingLineups.count == 11,
              responseGame.first?.lineup.away.startingLineups.count == 11 else {
            contextGameDetails.gameDetailsContext = responseGame
            return
        }

        guard let homeLineup = responseGame.first?.lineup.home.startingLineups,
              let awayLineup = responseGame.first?.lineup.away.startingLineups,
              let startLineupHome = await fetchImagePlayer(with: homeLineup),
              let startLineupAway = await fetchImagePlayer(with: awayLineup) else { return }

        detailGame[0].lineup.home.startingLineups = startLineupHome
        detailGame[0].lineup.away.startingLineups = startLineupAway
        contextGameDetails.gameDetailsContext = detailGame
    }

    private func fetchImagePlayer(with lineup: [PlayerAndCoach]) async -> [PlayerAndCoach]? {
        var lineupResponse = lineup
        let countPlayer = lineup.count

        for i in 0...countPlayer - 1 {
            guard let playerKey = lineup[i].playerKey else {
                return nil
            }
            switch await request.fetchPlayer(keyPlayer: playerKey) {
            case .success(let playerImage):
                lineupResponse[i].playerKey = playerImage.first?.imagePlayer
            case .failure(_):
                print("error")
            }
        }
        return lineupResponse
    }


    private func presenteResponse(with detailsGame: [RestDatailsGame]) {
        let response = mapDetailsGame(with: detailsGame)
        presenter?.presentInterface(with: response)
    }

    private func mapDetailsGame(with restDetailsGame: [RestDatailsGame]) -> [GameDetailsModels.Response] {
        return restDetailsGame.compactMap { detail in
            let scorer = mapScorer(with: detail.goalscorer)
            let card = mapCards(with: detail.cards)
            let lineup = mapDetailLineup(with: detail.lineup)

            return GameDetailsModels.Response(matchId: detail.matchId,
                                              countryName: detail.countryName,
                                              leagueName: detail.leagueName,
                                              matchStatus: detail.matchStatus,
                                              matchTime: detail.matchTime,
                                              homeTeamName: detail.homeTeamName,
                                              homeTeamScore: detail.homeTeamScore,
                                              awayTeamName: detail.awayTeamName,
                                              awayTeamScore: detail.awayTeamScore,
                                              matchHometeamSystem: detail.matchHometeamSystem,
                                              matchAwayteamSystem: detail.matchAwayteamSystem,
                                              stadium: detail.stadium,
                                              referee: detail.referee,
                                              homeBadge: detail.homeBadge,
                                              awayBadge: detail.awayBadge,
                                              leagueLogo: detail.leagueLogo,
                                              countryLogo: detail.countryLogo,
                                              goalscorer: scorer,
                                              cards: card,
                                              lineup: lineup)
        }
    }

    private func mapScorer(with restScorer: [Scorer]) -> [GameDetailsModels.Response.Scorer] {
        return restScorer.compactMap { scorer in
            return GameDetailsModels.Response.Scorer(time: scorer.time,
                                                     nameScorerHome: scorer.nameScorerHome,
                                                     scorerHomeId: scorer.scorerHomeId,
                                                     homeAssist: scorer.homeAssist,
                                                     nameScorerAway: scorer.nameScorerAway,
                                                     scorerAwayId: scorer.scorerAwayId,
                                                     awayAssist: scorer.awayAssist)
        }
    }

    private func mapCards(with restCards: [Cards]) -> [GameDetailsModels.Response.Cards] {
        return restCards.compactMap { card in
            return GameDetailsModels.Response.Cards(time: card.time,
                                                    homeFault: card.homeFault,
                                                    card: card.card,
                                                    awayFault: card.awayFault,
                                                    homePlayerId: card.homePlayerId,
                                                    awayPlayerId: card.awayPlayerId)

        }
    }

    private func mapDetailLineup(with restLineup: Lineup) -> GameDetailsModels.Response.Lineup {
        let homeLineup = mapTeamLineup(with: restLineup.home)
        let awayLineup = mapTeamLineup(with: restLineup.away)
        return GameDetailsModels.Response.Lineup(home: homeLineup,
                                                 away: awayLineup)
    }

    private func mapTeamLineup(with restTeamLineup: TeamLineup) -> GameDetailsModels.Response.TeamLineup {
        let startingLineups = mapLineup(with: restTeamLineup.startingLineups)
        let substitutes = mapLineup(with: restTeamLineup.substitutes)
        let coach = mapLineup(with: restTeamLineup.coach)
        return GameDetailsModels.Response.TeamLineup(startingLineups: startingLineups,
                                                     substitutes: substitutes,
                                                     coach: coach)
    }

    private func mapLineup(with restPlayerAndCoach: [PlayerAndCoach]) -> [GameDetailsModels.Response.PlayerAndCoach] {
        return restPlayerAndCoach.compactMap { playerAndCoach in
            return GameDetailsModels.Response.PlayerAndCoach(player: playerAndCoach.player,
                                                              number: playerAndCoach.number,
                                                              position: playerAndCoach.position,
                                                              playerKey: playerAndCoach.playerKey)
        }
    }
}

extension GameDetailsInteractor: GameDetailsBusinessLogic {
    func start(gameId: String) async {
        Task {
            await fetchGame(game: gameId)
        }
    }
}
