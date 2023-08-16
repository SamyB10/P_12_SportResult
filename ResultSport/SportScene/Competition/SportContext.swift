//
//  SportContext.swift
//  Sport
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation
//import SportModuleKit

struct SportContext: Equatable {
    
    var sportContext: [RestCompetitions]?
    var didFailLoading: Bool = false
    
    mutating func willLoadContent() {
        sportContext = nil
        didFailLoading = false
    }
}
