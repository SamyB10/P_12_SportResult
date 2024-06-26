//
//  CompetitionBusinessLogic.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

public protocol CompetitionBusinessLogic {
    func start() async
    func nextPage(id: String)
    func fetchCountry(id: String) async
}
