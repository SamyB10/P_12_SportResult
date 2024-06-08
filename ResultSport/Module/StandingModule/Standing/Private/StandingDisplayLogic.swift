//
//  File.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

protocol StandingDisplayLogic: AnyObject {
    func displayInterface(with viewModel: [StandingModels.ViewModel])
    func updateInterface(with viewModel: [StandingModels.ViewModel])
    func displayError(with error: Error)
    func displayLoader()
}
