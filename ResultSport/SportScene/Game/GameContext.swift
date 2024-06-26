//
//  GameContext.swift
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

struct GameContext: Equatable {

    var gameContext: [RestSchedule]?
    var didFailLoading: Bool = false

    mutating func willLoadContent() {
        gameContext = nil
        didFailLoading = false
    }
}
