//
//  StandingBusinessLogic.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import UIKit

public protocol StandingBusinessLogic {
    func start() async
    func fetch(leagueId: String) async
}
