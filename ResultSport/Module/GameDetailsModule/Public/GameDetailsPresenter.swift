//
//  CompetitionPresenter.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

public protocol GameDetailsPresentationLogic: AnyObject {
    func presentInterface(with response: [GameDetailsModels.Response])
    func presentLoader()
    func presentError(with error: Error)
}

public final class GameDetailsPresenter {
    
    private weak var display: GameDetailsDisplayLogic?
    private var interactor: GameDetailsBusinessLogic
    private var viewModel: GameDetailsModels.ViewModel?

    public init(interactor: GameDetailsBusinessLogic) {
        self.interactor = interactor
    }
    
    func inject(display: GameDetailsDisplayLogic) {
        self.display = display
    }

    private func mapResponseDetailsGame(with response: [GameDetailsModels.Response]) -> [GameDetailsModels.ViewModel] {
        return response.compactMap { detail in
            guard let goalScorer = response.first?.goalscorer else { return nil }
            let homeLineup = mapResponseLineupHome(with: detail.lineup, scorer: goalScorer)
            let awayLineup = mapResponseLineupAway(with: detail.lineup, scorer: goalScorer)
            return GameDetailsModels.ViewModel(homeTeamSysteme: detail.matchHometeamSystem,
                                               awayTeamSysteme: detail.matchAwayteamSystem,
                                               home: homeLineup,
                                               away: awayLineup,
                                               nameTeamHome: detail.homeTeamName,
                                               nameTeamAway: detail.awayTeamName,
                                               scoreTeamHome: detail.homeTeamScore,
                                               scoreTeamAway: detail.awayTeamScore,
                                               teamHomeLogo: detail.homeBadge,
                                               teamAwayLogo: detail.awayBadge,
                                               statusMatch: detail.matchStatus,
                                               nameSoccer: detail.stadium)
        }
    }

    private func mapResponseLineupHome(with response: GameDetailsModels.Response.Lineup,
                                       scorer: [GameDetailsModels.Response.Scorer]) -> [GameDetailsModels.ViewModel.LineupTeam]? {

        return response.home?.startingLineups?.compactMap { player in
            let namePlayer = player.player
            let numberPlayer = player.number
            let positionPlayer = player.position
            let playerKey = player.playerKey
            let scorer = goalScorerHome(with: scorer, player: player)
            return GameDetailsModels.ViewModel.LineupTeam(namePlayer: namePlayer,
                                                          numberPlayer: numberPlayer,
                                                          postionPlayer: positionPlayer,
                                                          idPlayer: playerKey,
                                                          goalScorer: scorer)
        }
    }

    private func mapResponseLineupAway(with response: GameDetailsModels.Response.Lineup,
                                       scorer: [GameDetailsModels.Response.Scorer]) -> [GameDetailsModels.ViewModel.LineupTeam]? {
        return response.away?.startingLineups?.compactMap { player in
            let namePlayer = player.player
            let numberPlayer = player.number
            let positionPlayer = player.position
            let playerKey = player.playerKey
            let scorer = goalScorerAway(with: scorer, player: player)
            return GameDetailsModels.ViewModel.LineupTeam(namePlayer: namePlayer,
                                                          numberPlayer: numberPlayer,
                                                          postionPlayer: positionPlayer,
                                                          idPlayer: playerKey,
                                                          goalScorer: scorer)
        }
    }

    private func goalScorerHome(with response: [GameDetailsModels.Response.Scorer],
                            player: GameDetailsModels.Response.PlayerAndCoach) -> Bool {
        for scorer in response {
            guard scorer.scorerHomeId != player.playerKey else {
                return true
            }
        }
        return false
    }

    private func goalScorerAway(with response: [GameDetailsModels.Response.Scorer],
                            player: GameDetailsModels.Response.PlayerAndCoach) -> Bool {
        for scorer in response {
            guard scorer.scorerAwayId != player.playerKey else {
                return true
            }
        }
        return false
    }
}


extension GameDetailsPresenter: GameDetailsPresentationLogic {

    public func presentInterface(with response: [GameDetailsModels.Response]) {
        let viewModel = mapResponseDetailsGame(with: response)
        self.viewModel = viewModel.first
        display?.displayInterface(with: viewModel)
    }

    public func presentLoader() {
        display?.displayLoader()
    }

    public func presentError(with error: Error) {

    }
}

extension GameDetailsPresenter: GameDetailsInteractionLogic {
    func didSelectLineup(index: Int) {
        guard let viewModelHome = viewModel?.home,
              let viewModelAway = viewModel?.away else { return }
        switch index {
        case 0:
            display?.updateInterface(with: viewModelHome)
        case 1:
            display?.updateInterface(with: viewModelAway)
        default:
            break
        }
    }


    func didFetchDetails(gameId: String) {
        Task {
            await interactor.start(gameId: gameId)
        }
    }

    func didSelect(id: String) {

    }
}
