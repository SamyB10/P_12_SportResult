//
//  File.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

public enum StandingModels: Equatable {
    public struct Response: Equatable {
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
        
        public init(countryName: String?,
                    leagueName: String?,
                    teamId: String?,
                    teamName: String?,
                    teamLogo: String?,
                    promotion: String?,
                    leaguePosition: String?,
                    leaguePlayed: String?,
                    gameWin: String?,
                    gameNul: String?,
                    gameLose: String?,
                    standingPts: String?) {
            self.countryName = countryName
            self.leagueName = leagueName
            self.teamId = teamId
            self.teamName = teamName
            self.teamLogo = teamLogo
            self.promotion = promotion
            self.leaguePosition = leaguePosition
            self.leaguePlayed = leaguePlayed
            self.gameWin = gameWin
            self.gameNul = gameNul
            self.gameLose = gameLose
            self.standingPts = standingPts
        }
    }
    
    public struct ViewModel: Equatable, Hashable {
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
        
        public init(countryName: String?,
                    leagueName: String?,
                    teamId: String?,
                    teamName: String?,
                    teamLogo: String?,
                    promotion: String?,
                    leaguePosition: String?,
                    leaguePlayed: String?,
                    gameWin: String?,
                    gameNul: String?,
                    gameLose: String?,
                    standingPts: String?) {
            self.countryName = countryName
            self.leagueName = leagueName
            self.teamId = teamId
            self.teamName = teamName
            self.teamLogo = teamLogo
            self.promotion = promotion
            self.leaguePosition = leaguePosition
            self.leaguePlayed = leaguePlayed
            self.gameWin = gameWin
            self.gameNul = gameNul
            self.gameLose = gameLose
            self.standingPts = standingPts
        }
    }
}
