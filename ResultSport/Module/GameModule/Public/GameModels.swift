//
//  GameModels.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

public enum GameModels: Equatable {
    public struct Response: Equatable {
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
        
        public init(matchId: String?,
                    countryId: String?,
                    countryName: String?,
                    leagueId: String?,
                    leagueName: String?,
                    matchStatus: String?,
                    matchTime: String?,
                    homeTeamName: String?,
                    homeTeamScore: String?,
                    awayTeamName: String?,
                    awayTeamScore: String?,
                    stadium: String?,
                    homeBadge: String?,
                    awayBadge: String?,
                    leagueLogo: String?) {
            self.matchId = matchId
            self.countryId = countryId
            self.countryName = countryName
            self.leagueId = leagueId
            self.leagueName = leagueName
            self.matchStatus = matchStatus
            self.matchTime = matchTime
            self.homeTeamName = homeTeamName
            self.homeTeamScore = homeTeamScore
            self.awayTeamName = awayTeamName
            self.awayTeamScore = awayTeamScore
            self.stadium = stadium
            self.homeBadge = homeBadge
            self.awayBadge = awayBadge
            self.leagueLogo = leagueLogo
        }
    }
    
    public struct ViewModel: Equatable, Hashable {
        public let day: String
        public let dayNumber: String
        public let isActive: Bool
        
        public init(day: String,
                    dayNumber: String,
                    isActive: Bool) {
            self.day = day
            self.dayNumber = dayNumber
            self.isActive = isActive
        }
        
        public struct Game: Equatable, Hashable {
            public let countryName: String
            public let leagueId: String
            public let leagueName: String
            public let matchStatus: String
            public let matchTime: String
            public let homeTeamName: String
            public let homeTeamScore: String
            public let awayTeamName: String
            public let awayTeamScore: String
            public let stadium: String
            public let homeBadge: String
            public let awayBadge: String
            public let leagueLogo: String
            public let matchId: String

            public init(countryName: String,
                        leagueId: String,
                        leagueName: String,
                        matchStatus: String,
                        matchTime: String,
                        homeTeamName: String,
                        homeTeamScore: String,
                        awayTeamName: String,
                        awayTeamScore: String,
                        stadium: String,
                        homeBadge: String,
                        awayBadge: String,
                        leagueLogo: String,
                        matchId: String) {
                self.countryName = countryName
                self.leagueId = leagueId
                self.leagueName = leagueName
                self.matchStatus = matchStatus
                self.matchTime = matchTime
                self.homeTeamName = homeTeamName
                self.homeTeamScore = homeTeamScore
                self.awayTeamName = awayTeamName
                self.awayTeamScore = awayTeamScore
                self.stadium = stadium
                self.homeBadge = homeBadge
                self.awayBadge = awayBadge
                self.leagueLogo = leagueLogo
                self.matchId = matchId
            }
        }

        public struct League {
            public var spanishLeague: [Game]
            public var englishLeague: [Game]
            public var frenchLeague: [Game]
            public var italyLeague: [Game]
            public var germanyLeague: [Game]
            public var championsLeague: [Game]
            public var europaLeague: [Game]
            public var word: [Game]

            public init(spanishLeague: [Game] = [],
                        englishLeague: [Game] = [],
                        frenchLeague: [Game] = [],
                        italyLeague: [Game] = [],
                        germanyLeague: [Game] = [],
                        championsLeague: [Game] = [],
                        europaLeague: [Game] = [],
                        word: [Game] = []) {
                self.spanishLeague = spanishLeague
                self.englishLeague = englishLeague
                self.frenchLeague = frenchLeague
                self.italyLeague = italyLeague
                self.germanyLeague = germanyLeague
                self.championsLeague = championsLeague
                self.europaLeague = europaLeague
                self.word = word
            }
        }
        
        public struct Championship: Equatable, Hashable {
            public let spanishLeague: [Game]
            public let frenchLeague: [Game]
            public let englishLeague: [Game]
            public let italyLeague: [Game]
            public let germanyLeague: [Game]
            public let word: [Game]
            public let championsLeague: [Game]
            public let europaLeague: [Game]

            public init(spanishLeague: [Game],
                        frenchLeague: [Game],
                        englishLeague: [Game],
                        italyLeague: [Game],
                        germanyLeague: [Game],
                        word: [Game],
                        championsLeague: [Game],
                        europaLeague: [Game]) {
                self.spanishLeague = spanishLeague
                self.frenchLeague = frenchLeague
                self.englishLeague = englishLeague
                self.italyLeague = italyLeague
                self.germanyLeague = germanyLeague
                self.word = word
                self.championsLeague = championsLeague
                self.europaLeague = europaLeague
            }
        }

        public struct ViewModelPicker {
            let leagues: [String: String] = ["302" : "LaLiga",
                                             "168" : "Ligue 1",
                                             "152" : "Premiere League",
                                             "207" : "Serie A",
                                             "175" : "Bundesliga",
                                             "0" : "Word",
                                             "3" : "ChampionsLeague",
                                             "4" : "EuropaLeague"]
        }
    }
}
