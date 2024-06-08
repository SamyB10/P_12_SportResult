//
//  RestSchedule.swift
//  Sport
//
//  Created by Samy Boussair on 02/08/2023.
//

import Foundation

public struct RestSchedule: Decodable, Equatable {

    public let matchId: String?
    public let countryId: String?
    public let countryName: String?
    public let leagueId: String?
    public let leagueName: String?
    public let matchStatus: String?
    public let matchTime: String?
    public let homeTeamName: String?
    public let homeTeamScore: String?
    public let awayTeamName: String?
    public let awayTeamScore: String?
    public let stadium: String?
    public let homeBadge: String?
    public let awayBadge: String?
    public let leagueLogo: String?

    private enum CodingKeys: String, CodingKey {
        case matchId = "match_id"
        case countryId = "country_id"
        case countryName = "country_name"
        case leagueId = "league_id"
        case leagueName = "league_name"
        case matchStatus = "match_status"
        case matchTime = "match_time"
        case homeTeamName = "match_hometeam_name"
        case homeTeamScore = "match_hometeam_score"
        case awayTeamName = "match_awayteam_name"
        case awayTeamScore = "match_awayteam_score"
        case stadium = "match_stadium"
        case homeBadge = "team_home_badge"
        case awayBadge = "team_away_badge"
        case leagueLogo = "league_logo"
    }
}
