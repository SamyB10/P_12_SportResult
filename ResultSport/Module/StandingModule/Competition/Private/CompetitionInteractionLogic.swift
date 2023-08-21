//
//  File.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

protocol CompetitionInteractionLogic {
    func didLoad()
    func didSelect(id: String)
    func searchCompetition(country: String)
    func textFieldGood(country: String) -> CountryError?
}
