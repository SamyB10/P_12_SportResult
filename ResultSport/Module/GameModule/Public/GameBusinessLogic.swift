//
//  GameBusinessLogic.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

public protocol GameBusinessLogic {
    func start(from: String, to: String, withLive: Bool) async
}
