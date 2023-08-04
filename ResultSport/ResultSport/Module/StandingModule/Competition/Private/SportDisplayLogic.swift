//
//  File.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

protocol SportDisplayLogic: AnyObject {
    func displayInterface(with viewModel: [SportModels.ViewModel])
    func updateInterface(with viewModel: [SportModels.ViewModel])
    func displayError(with error: Error)
    func displayLoader()
}
