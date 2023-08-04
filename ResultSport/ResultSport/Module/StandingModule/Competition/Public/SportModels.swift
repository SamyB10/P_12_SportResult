//
//  File.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

public enum SportModels: Equatable {
    public struct Response: Equatable {
        public let countryId: String
        public let countryName: String
        public let leagueId: String
        public let leagueName: String
        public let leagueSeason: String
        public let leagueLogo: String
        public let countryLogo: String

        public init(countryId: String,
                    countryName: String,
                    leagueId: String,
                    leagueName: String,
                    leagueSeason: String,
                    leagueLogo: String,
                    countryLogo: String) {
            self.countryId = countryId
            self.countryName = countryName
            self.leagueId = leagueId
            self.leagueName = leagueName
            self.leagueSeason = leagueSeason
            self.leagueLogo = leagueLogo
            self.countryLogo = countryLogo
        }
    }

    public struct ViewModel: Equatable, Hashable {
        public let countryName: String
        public let leagueId: String
        public let leagueName: String
        public let leagueLogo: String
        public let countryLogo: String

        public init(countryName: String,
                    leagueId: String,
                    leagueName: String,
                    leagueLogo: String,
                    countryLogo: String) {
            self.countryName = countryName
            self.leagueId = leagueId
            self.leagueName = leagueName
            self.leagueLogo = leagueLogo
            self.countryLogo = countryLogo
        }
    }
}
