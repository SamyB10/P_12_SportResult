//
//  GameResponse.swift
//  ResultSport
//
//  Created by Samy Boussair on 04/08/2023.
//

import Foundation

extension GameModels.Response {
    var viewModel: GameModels.ViewModel.Game? {
        guard let countryName = countryName,
              let leagueId = leagueId,
              let leagueName = leagueName,
              let matchStatus = matchStatus,
              let matchTime = matchTime,
              let homeTeamName = homeTeamName,
              let homeTeamScore = homeTeamScore,
              let awayTeamName = awayTeamName,
              let awayTeamScore = awayTeamScore,
              let stadium = stadium,
              let homeBadge = homeBadge,
              let awayBadge = awayBadge,
              let leagueLogo = leagueLogo else { return nil }

        return GameModels.ViewModel.Game(countryName: countryName,
                                         leagueId: leagueId,
                                         leagueName: leagueName,
                                         matchStatus: matchStatus,
                                         matchTime: matchTime,
                                         homeTeamName: homeTeamName,
                                         homeTeamScore: homeTeamScore,
                                         awayTeamName: awayTeamName,
                                         awayTeamScore: awayTeamScore,
                                         stadium: stadium,
                                         homeBadge: homeBadge,
                                         awayBadge: awayBadge,
                                         leagueLogo: leagueLogo)
    }
}
