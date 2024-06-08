//
//  SportContext.swift
//  Sport
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

struct GameDetailsContext: Equatable {
    
    var gameDetailsContext: [RestDatailsGame]?
    var didFailLoading: Bool = false

    mutating func willLoadContent() {
        gameDetailsContext = nil
        didFailLoading = false
    }
}
