//
//  CompetitionContext.swift
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

struct CompetitionContext: Equatable {
    
    var competitionContext: [RestCompetitions]?
    var didFailLoading: Bool = false
    
    mutating func willLoadContent() {
        competitionContext = nil
        didFailLoading = false
    }
}
