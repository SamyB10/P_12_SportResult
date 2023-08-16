//
//  StandingsRestModels.swift
//  Sport
//
//  Created by Samy Boussair on 28/07/2023.
//

public struct RestCompetitions: Decodable, Equatable {
    
    public let countryId: String?
    public let countryName: String?
    public let leagueId: String?
    public let leagueName: String?
    public let leagueSeason: String?
    public let leagueLogo: String?
    public let countryLogo: String?
    
    private enum CodingKeys: String, CodingKey {
        case countryId = "country_id"
        case countryName = "country_name"
        case leagueId = "league_id"
        case leagueName = "league_name"
        case leagueSeason = "league_season"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
}
