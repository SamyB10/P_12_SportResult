//
//  CompetitionDisplayLogic.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

protocol GameDetailsDisplayLogic: AnyObject {
    func displayInterface(with viewModel: [GameDetailsModels.ViewModel])
    func updateInterface(with viewModel: [GameDetailsModels.ViewModel.LineupTeam])
    func displayError(with error: Error)
    func displayLoader()
}
