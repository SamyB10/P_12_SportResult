//
//  File.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

protocol GameDisplayLogic: AnyObject {
    func displayInterface(with viewModel: [GameModels.ViewModel])
    func updateInterface(with viewModel: [GameModels.ViewModel])

    func displayInterfaceGame(with viewModel: GameModels.ViewModel.Championship)
    func updateInterfaceGame(with viewModel: [GameModels.ViewModel.Game])
    
    func displayError(with error: Error)
    func displayLoader()
}
