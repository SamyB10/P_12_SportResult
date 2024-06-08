//
//  CompetitionInteractionLogic.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

protocol GameDetailsInteractionLogic {
    func didFetchDetails(gameId: String)
    func didSelect(id: String)
    func didSelectLineup(index: Int)
}
