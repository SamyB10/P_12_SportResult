//
//  SportContext.swift
//  Sport
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

struct StandingContext: Equatable {
    
    var standingContext: [RestStanding]?
    var didFailLoading: Bool = false

    mutating func willLoadContent() {
        standingContext = nil
        didFailLoading = false
    }
}
