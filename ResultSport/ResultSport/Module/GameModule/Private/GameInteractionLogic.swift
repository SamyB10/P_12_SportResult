//
//  File 2.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

protocol GameInteractionLogic {
    func didLoad()
    func fetchGame(from: String, to: String)
    func didSelectItem(indexPath: Int)
}
