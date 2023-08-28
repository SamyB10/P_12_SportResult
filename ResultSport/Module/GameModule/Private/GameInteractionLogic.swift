//
//  GameInteractionLogic.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

protocol GameInteractionLogic {
    func didLoad()
    func fetchGame(from: String, to: String, withLive: Bool)
    func didSelectItem(indexPath: Int)
    func didSelectLeague(id: String)
    func didSelectStatusGame(index: Int)
}
