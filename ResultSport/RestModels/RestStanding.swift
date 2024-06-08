//
//  RestStanding.swift
//  ResultSport
//
//  Created by Samy Boussair on 07/08/2023.
//

import Foundation
public struct RestStanding: Decodable, Equatable {

    public let countryName: String?
    public let leagueName: String?
    public let teamId: String?
    public let teamName: String?
    public let teamLogo: String?
    public let promotion: String?
    public let leaguePosition: String?
    public let leaguePlayed: String?
    public let gameWin: String?
    public let gameNul: String?
    public let gameLose: String?
    public let standingPts: String?

    private enum CodingKeys: String, CodingKey {
        case countryName = "country_name"
        case leagueName = "league_name"
        case teamId = "team_id"
        case teamName = "team_name"
        case teamLogo = "team_badge"
        case promotion = "overall_promotion"
        case leaguePosition = "overall_league_position"
        case leaguePlayed = "overall_league_payed"
        case gameWin = "overall_league_W"
        case gameNul = "overall_league_D"
        case gameLose = "overall_league_L"
        case standingPts = "overall_league_PTS"
    }
}
