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

//
//    "overall_league_W": "0",
//    "overall_league_D": "0",
//    "overall_league_L": "0",
//    "overall_league_GF": "0",
//    "overall_league_GA": "0",
//    "overall_league_PTS": "0",
//    "home_league_position": "1",
//    "home_promotion": "",
//    "home_league_payed": "0",
//    "home_league_W": "0",
//    "home_league_D": "0",
//    "home_league_L": "0",
//    "home_league_GF": "0",
//    "home_league_GA": "0",
//    "home_league_PTS": "0",
//    "away_league_position": "1",
//    "away_promotion": "",
//    "away_league_payed": "0",
//    "away_league_W": "0",
//    "away_league_D": "0",
//    "away_league_L": "0",
//    "away_league_GF": "0",
//    "away_league_GA": "0",
//    "away_league_PTS": "0",
//    "league_round": "",
//    "team_badge": "https://apiv3.apifootball.com/badges/141_arsenal.jpg",
//    "fk_stage_key": "6",
//    "stage_name": "Current"
//  },
//  {
//    "country_name": "England",
//    "league_id": "152",
//    "league_name": "Premier League",
//    "team_id": "3088",
//    "team_name": "Aston Villa",
//    "overall_promotion": "Promotion - Champions League (Group Stage: )",
//    "overall_league_position": "2",
//    "overall_league_payed": "0",
//    "overall_league_W": "0",
//    "overall_league_D": "0",
//    "overall_league_L": "0",
//    "overall_league_GF": "0",
//    "overall_league_GA": "0",
//    "overall_league_PTS": "0",
//    "home_league_position": "2",
//    "home_promotion": "",
//    "home_league_payed": "0",
//    "home_league_W": "0",
//    "home_league_D": "0",
//    "home_league_L": "0",
//    "home_league_GF": "0",
//    "home_league_GA": "0",
//    "home_league_PTS": "0",
//    "away_league_position": "2",
//    "away_promotion": "",
//    "away_league_payed": "0",
//    "away_league_W": "0",
//    "away_league_D": "0",
//    "away_league_L": "0",
//    "away_league_GF": "0",
//    "away_league_GA": "0",
//    "away_league_PTS": "0",
//    "league_round": "",
//    "team_badge": "https://apiv3.apifootball.com/badges/3088_aston-villa.jpg",
//    "fk_stage_key": "6",
//    "stage_name": "Current"
//  },
