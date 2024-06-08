//
//  CompetitionModels.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

public enum GameDetailsModels: Equatable {
    public struct Response: Equatable {
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
        public let lineup: Lineup
        
        public init(matchId: String?,
                    countryName: String?,
                    leagueName: String?,
                    matchStatus: String?,
                    matchTime: String?,
                    homeTeamName: String?,
                    homeTeamScore: String?,
                    awayTeamName: String?,
                    awayTeamScore: String?,
                    matchHometeamSystem: String?,
                    matchAwayteamSystem: String?,
                    stadium: String?,
                    referee: String?,
                    homeBadge: String?,
                    awayBadge: String?,
                    leagueLogo: String?,
                    countryLogo: String?,
                    goalscorer: [Scorer],
                    cards: [Cards],
                    lineup: Lineup) {
            self.matchId = matchId
            self.countryName = countryName
            self.leagueName = leagueName
            self.matchStatus = matchStatus
            self.matchTime = matchTime
            self.homeTeamName = homeTeamName
            self.homeTeamScore = homeTeamScore
            self.awayTeamName = awayTeamName
            self.awayTeamScore = awayTeamScore
            self.matchHometeamSystem = matchHometeamSystem
            self.matchAwayteamSystem = matchAwayteamSystem
            self.stadium = stadium
            self.referee = referee
            self.homeBadge = homeBadge
            self.awayBadge = awayBadge
            self.leagueLogo = leagueLogo
            self.countryLogo = countryLogo
            self.goalscorer = goalscorer
            self.cards = cards
            self.lineup = lineup
        }

        public struct ImagePlayer: Equatable {
            public let imagePlayer: String?

            public init(imagePlayer: String?) {
                self.imagePlayer = imagePlayer
            }
        }
        
        public struct Lineup: Equatable {
            public let home: TeamLineup?
            public let away: TeamLineup?
            
            public init(home: TeamLineup?,
                        away: TeamLineup?) {
                self.home = home
                self.away = away
            }
        }
        
        public struct TeamLineup: Equatable {
            public let startingLineups: [PlayerAndCoach]?
            public let substitutes: [PlayerAndCoach]?
            public let coach: [PlayerAndCoach]?
            
            public init(startingLineups: [PlayerAndCoach]?,
                        substitutes: [PlayerAndCoach]?,
                        coach: [PlayerAndCoach]?) {
                self.startingLineups = startingLineups
                self.substitutes = substitutes
                self.coach = coach
            }
        }
        
        public struct PlayerAndCoach: Equatable {
            public let player: String?
            public let number: String?
            public let position: String?
            public let playerKey: String?
            
            public init(player: String?,
                        number: String?,
                        position: String?,
                        playerKey: String?) {
                self.player = player
                self.number = number
                self.position = position
                self.playerKey = playerKey
            }
        }
        
        public struct Scorer: Equatable {
            public let time: String?
            public let nameScorerHome: String?
            public let scorerHomeId: String?
            public let homeAssist: String?
            public let nameScorerAway: String?
            public let scorerAwayId: String?
            public let awayAssist: String?
            
            public init(time: String?,
                        nameScorerHome: String?,
                        scorerHomeId: String?,
                        homeAssist: String?,
                        nameScorerAway: String?,
                        scorerAwayId: String?,
                        awayAssist: String?) {
                self.time = time
                self.nameScorerHome = nameScorerHome
                self.scorerHomeId = scorerHomeId
                self.homeAssist = homeAssist
                self.nameScorerAway = nameScorerAway
                self.scorerAwayId = scorerAwayId
                self.awayAssist = awayAssist
            }
        }
        
        public struct Cards: Equatable {
            public let time: String?
            public let homeFault: String?
            public let card: String?
            public let awayFault: String?
            public let homePlayerId: String?
            public let awayPlayerId: String?
            
            public init(time: String?,
                        homeFault: String?,
                        card: String?,
                        awayFault: String?,
                        homePlayerId: String?,
                        awayPlayerId: String?) {
                self.time = time
                self.homeFault = homeFault
                self.card = card
                self.awayFault = awayFault
                self.homePlayerId = homePlayerId
                self.awayPlayerId = awayPlayerId
            }
        }
    }
    
    public struct ViewModel: Equatable, Hashable {
        public let homeTeamSysteme: String?
        public let awayTeamSysteme: String?
        public let home: [LineupTeam]?
        public let away: [LineupTeam]?
        public let nameTeamHome: String?
        public let nameTeamAway: String?
        public let scoreTeamHome: String?
        public let scoreTeamAway: String?
        public let teamHomeLogo: String?
        public let teamAwayLogo: String?
        public let statusMatch: String?
        public let nameSoccer: String?

        
        public init(homeTeamSysteme: String?,
                    awayTeamSysteme: String?,
                    home: [LineupTeam]?,
                    away: [LineupTeam]?,
                    nameTeamHome: String?,
                    nameTeamAway: String?,
                    scoreTeamHome: String?,
                    scoreTeamAway: String?,
                    teamHomeLogo: String?,
                    teamAwayLogo: String?,
                    statusMatch: String?,
                    nameSoccer: String?) {
            self.homeTeamSysteme = homeTeamSysteme
            self.awayTeamSysteme = awayTeamSysteme
            self.home = home
            self.away = away
            self.nameTeamHome = nameTeamHome
            self.nameTeamAway = nameTeamAway
            self.scoreTeamHome = scoreTeamHome
            self.scoreTeamAway = scoreTeamAway
            self.teamHomeLogo = teamHomeLogo
            self.teamAwayLogo = teamAwayLogo
            self.statusMatch = statusMatch
            self.nameSoccer = nameSoccer
        }
        
        
        public struct LineupTeam: Equatable, Hashable {
            public let namePlayer: String?
            public let numberPlayer: String?
            public let postionPlayer: String?
            public let idPlayer: String?
            public let goalScorer: Bool?
            
            public init(namePlayer: String?,
                        numberPlayer: String?,
                        postionPlayer: String?,
                        idPlayer: String?,
                        goalScorer: Bool?) {
                self.namePlayer = namePlayer
                self.numberPlayer = numberPlayer
                self.postionPlayer = postionPlayer
                self.idPlayer = idPlayer
                self.goalScorer = goalScorer
            }
        }
    }
}
