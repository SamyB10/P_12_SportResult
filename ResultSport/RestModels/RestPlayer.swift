//
//  RestPlayer.swift
//  ResultSport
//
//  Created by Samy Boussair on 31/08/2023.
//

import Foundation

public struct RestPlayer: Decodable, Equatable {

    public let imagePlayer: String?

    private enum CodingKeys: String, CodingKey {
        case imagePlayer = "player_image"
    }
}
