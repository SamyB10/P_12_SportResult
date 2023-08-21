//
//  CompetitionDisplayLogic.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

protocol CompetitionDisplayLogic: AnyObject {
    func displayInterface(with viewModel: [CompetitionModels.ViewModel])
    func updateInterface(with viewModel: [CompetitionModels.ViewModel])
    func displayError(with error: Error)
    func displayLoader()
}
