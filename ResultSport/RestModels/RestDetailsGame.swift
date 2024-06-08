//
//  RestDetailsGame.swift
//  ResultSport
//
//  Created by Samy Boussair on 30/08/2023.
//

import Foundation

public struct RestDatailsGame: Decodable, Equatable {

    public let matchId: String?
    public let countryName: String?
    public let leagueName: String?
    public let matchStatus: String?
    public let matchTime: String?
    public let homeTeamName: String?
    public let homeTeamScore: String?
    public let awayTeamName: String?
    public let awayTeamScore: String?
    public let matchHometeamSystem: String?
    public let matchAwayteamSystem: String?
    public let stadium: String?
    public let referee: String?
    public let homeBadge: String?
    public let awayBadge: String?
    public let leagueLogo: String?
    public let countryLogo: String?

    public let goalscorer: [Scorer]
    public let cards: [Cards]
//    public let substitutions: [String: String]
    public var lineup: Lineup

    private enum CodingKeys: String, CodingKey {
        case matchId = "match_id"
        case countryName = "country_name"
        case leagueName = "league_name"
        case matchStatus = "match_status"
        case matchTime = "match_time"
        case homeTeamName = "match_hometeam_name"
        case homeTeamScore = "match_hometeam_score"
        case awayTeamName = "match_awayteam_name"
        case awayTeamScore = "match_awayteam_score"
        case matchHometeamSystem = "match_hometeam_system"
        case matchAwayteamSystem = "match_awayteam_system"
        case stadium = "match_stadium"
        case referee = "match_referee"
        case homeBadge = "team_home_badge"
        case awayBadge = "team_away_badge"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
        case goalscorer
        case cards
        case lineup
    }
}

public struct Lineup: Decodable, Equatable {
    public var home: TeamLineup
    public var away: TeamLineup
}

public struct TeamLineup: Decodable, Equatable {
    public var startingLineups: [PlayerAndCoach]
    public let substitutes: [PlayerAndCoach]
    public let coach: [PlayerAndCoach]

    private enum CodingKeys: String, CodingKey {
        case startingLineups = "starting_lineups"
        case substitutes
        case coach
    }
}

public struct PlayerAndCoach: Decodable, Equatable {
    public let player: String?
    public let number: String?
    public let position: String?
    public var playerKey: String?

    private enum CodingKeys: String, CodingKey {
        case player = "lineup_player"
        case number = "lineup_number"
        case position = "lineup_position"
        case playerKey = "player_key"
    }
}

public struct Scorer: Decodable, Equatable {
    public let time: String?
    public let nameScorerHome: String?
    public let scorerHomeId: String?
    public let homeAssist: String?
    public let nameScorerAway: String?
    public let scorerAwayId: String?
    public let awayAssist: String?

    private enum CodingKeys: String, CodingKey {
        case time
        case nameScorerHome = "home_scorer"
        case scorerHomeId = "home_scorer_id"
        case homeAssist = "home_assist"
        case nameScorerAway = "away_scorer"
        case scorerAwayId = "away_scorer_id"
        case awayAssist = "away_assist"
    }
}

public struct Cards: Decodable, Equatable {
    public let time: String?
    public let homeFault: String?
    public let card: String?
    public let awayFault: String?
    public let homePlayerId: String?
    public let awayPlayerId: String?

    private enum CodingKeys: String, CodingKey {
        case time
        case homeFault = "home_fault"
        case card
        case awayFault = "away_fault"
        case homePlayerId = "home_player_id"
        case awayPlayerId = "away_player_id"
    }
}
