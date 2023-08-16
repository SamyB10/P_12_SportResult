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
//
//"match_id": "112282",
//    "country_id": "44",
//    "country_name": "England",
//    "league_id": "152",
//    "league_name": "Premier League",
//    "match_date": "2023-04-05",
//    "match_status": "Finished",
//    "match_time": "21:00",
//    "match_hometeam_id": "3081",
//    "match_hometeam_name": "West Ham United",
//    "match_hometeam_score": "1",
//    "match_awayteam_name": "Newcastle United",
//    "match_awayteam_id": "3100",
//    "match_awayteam_score": "5",
//    "match_hometeam_halftime_score": "1",
//    "match_awayteam_halftime_score": "2",
//    "match_hometeam_extra_score": "",
//    "match_awayteam_extra_score": "",
//    "match_hometeam_penalty_score": "",
//    "match_awayteam_penalty_score": "",
//    "match_hometeam_ft_score": "1",
//    "match_awayteam_ft_score": "5",
//    "match_hometeam_system": "4-2-3-1",
//    "match_awayteam_system": "4-3-3",
//    "match_live": "0",
//    "match_round": "7",
//    "match_stadium": "London Stadium (London)",
//    "match_referee": "C. Pawson",
//    "team_home_badge": "https://apiv3.apifootball.com/badges/3081_west-ham-united.jpg",
//    "team_away_badge": "https://apiv3.apifootball.com/badges/3100_newcastle-united.jpg",
//    "league_logo": "https://apiv3.apifootball.com/badges/logo_leagues/152_premier-league.png",
//    "country_logo": "https://apiv3.apifootball.com/badges/logo_country/44_england.png",
//    "league_year": "2022/2023",
//    "fk_stage_key": "6",
//    "stage_name": "Current",
