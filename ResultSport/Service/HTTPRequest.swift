//
//  HTTPRequest.swift
//  Sport
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation
import UIKit

enum HTTPError: Error {
    case invalidURL
    case unknown
    case noResponse
    case wrongStatusCode
    case invalideData
    case invalidImageData
}

struct HttpRequest {
    func fetchCountryAndLeague() async -> Result<[RestCompetitions], HTTPError> {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "apiv3.apifootball.com"
        urlComponents.path = "/"
        urlComponents.queryItems = [
            URLQueryItem(name: "action", value: "get_leagues"),
            URLQueryItem(name: "APIkey", value: Key.apiKey)
        ]

        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        guard let (data, response) = try? await URLSession.shared.data(for: request, delegate: nil) else { return .failure(.unknown)
        }

        guard let response = response as? HTTPURLResponse else {
            return .failure(.noResponse)
        }

        guard (200...299).contains(response.statusCode) else {
            return .failure(.wrongStatusCode)
        }

        guard let decodeResponse = try? JSONDecoder().decode([RestCompetitions].self, from: data) else {
            return .failure(.invalideData)
        }

        return .success(decodeResponse)
    }

    func fetchCountryAndLeague(id: String) async -> Result<[RestCompetitions], HTTPError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "apiv3.apifootball.com"
        urlComponents.path = "/"
        urlComponents.queryItems = [
            URLQueryItem(name: "action", value: "get_leagues"),
            URLQueryItem(name: "country_id", value: id),
            URLQueryItem(name: "APIkey", value: Key.apiKey)
        ]

        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        guard let (data, response) = try? await URLSession.shared.data(for: request, delegate: nil) else { return .failure(.unknown)
        }

        guard let response = response as? HTTPURLResponse else {
            return .failure(.noResponse)
        }

        guard (200...299).contains(response.statusCode) else {
            return .failure(.wrongStatusCode)
        }

        guard let decodeResponse = try? JSONDecoder().decode([RestCompetitions].self, from: data) else {
            return .failure(.invalideData)
        }

        return .success(decodeResponse)
    }


    func fetchSchedule(from: String, to: String, withLive: Bool) async -> Result<[RestSchedule], HTTPError> {

        var urlComponents: URLComponents

        switch withLive {
        case true:
            urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "apiv3.apifootball.com"
            urlComponents.path = "/"
            urlComponents.queryItems = [
                URLQueryItem(name: "action", value: "get_events"),
                URLQueryItem(name: "from", value: from),
                URLQueryItem(name: "to", value: to),
                URLQueryItem(name: "timezone", value: "Europe/Paris"),
                URLQueryItem(name: "match_live", value: "1"),
                URLQueryItem(name: "APIkey", value: Key.apiKey)
            ]
        case false:
            urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "apiv3.apifootball.com"
            urlComponents.path = "/"
            urlComponents.queryItems = [
                URLQueryItem(name: "action", value: "get_events"),
                URLQueryItem(name: "from", value: from),
                URLQueryItem(name: "to", value: to),
                URLQueryItem(name: "timezone", value: "Europe/Paris"),
                URLQueryItem(name: "APIkey", value: Key.apiKey)
            ]
        }

        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        guard let (data, response) = try? await URLSession.shared.data(for: request, delegate: nil) else { return .failure(.unknown)
        }

        guard let response = response as? HTTPURLResponse else {
            return .failure(.noResponse)
        }

        guard (200...299).contains(response.statusCode) else {
            return .failure(.wrongStatusCode)
        }

        guard let decodeResponse = try? JSONDecoder().decode([RestSchedule].self, from: data) else {
            return .failure(.invalideData)
        }

        return .success(decodeResponse)
    }

    func fetchStanding(leagueId: String) async -> Result<[RestStanding], HTTPError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "apiv3.apifootball.com"
        urlComponents.path = "/"
        urlComponents.queryItems = [
            URLQueryItem(name: "action", value: "get_standings"),
            URLQueryItem(name: "league_id", value: leagueId),
            URLQueryItem(name: "APIkey", value: Key.apiKey)
        ]

        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        guard let (data, response) = try? await URLSession.shared.data(for: request, delegate: nil) else { return .failure(.unknown)
        }

        guard let response = response as? HTTPURLResponse else {
            return .failure(.noResponse)
        }

        guard (200...299).contains(response.statusCode) else {
            return .failure(.wrongStatusCode)
        }

        guard let decodeResponse = try? JSONDecoder().decode([RestStanding].self, from: data) else {
            return .failure(.invalideData)
        }

        return .success(decodeResponse)
    }

    func fetchGame(gameId: String) async -> Result<[RestDatailsGame], HTTPError> {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "apiv3.apifootball.com"
        urlComponents.path = "/"
        urlComponents.queryItems = [
            URLQueryItem(name: "action", value: "get_events"),
            URLQueryItem(name: "timezone", value: "Europe/Paris"),
            URLQueryItem(name: "match_id", value: "\(gameId)"),
            URLQueryItem(name: "APIkey", value: Key.apiKey)
        ]

        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        guard let (data, response) = try? await URLSession.shared.data(for: request, delegate: nil) else { return .failure(.unknown)
        }

        guard let response = response as? HTTPURLResponse else {
            return .failure(.noResponse)
        }

        guard (200...299).contains(response.statusCode) else {
            return .failure(.wrongStatusCode)
        }

        guard var decodeResponse = try? JSONDecoder().decode([RestDatailsGame].self, from: data) else {
            return .failure(.invalideData)
        }

//        guard decodeResponse.first?.lineup.home.startingLineups.count == 11,
//              decodeResponse.first?.lineup.away.startingLineups.count == 11 else {
//            return .success(decodeResponse)
//        }
//
//        guard let countPlayer = decodeResponse.first?.lineup.home.startingLineups.count else {
//            return .failure(.unknown)
//        }
//        for i in 0...countPlayer - 1 {
//            guard let playerKey = decodeResponse.first?.lineup.home.startingLineups[i].playerKey else {
//                return .failure(.unknown)
//            }
//            switch await fetchPlayer(keyPlayer: playerKey) {
//            case .success(let playerImage):
//                decodeResponse[0].lineup.home.startingLineups[i].playerKey = playerImage.first?.imagePlayer
//            case .failure(_):
//                return .failure(.unknown)
//            }
//        }
//
//        guard let countPlayerAway = decodeResponse.first?.lineup.away.startingLineups.count else {
//            return .failure(.unknown)
//        }
//        for i in 0...countPlayerAway - 1{
//            guard let playerKey = decodeResponse.first?.lineup.away.startingLineups[i].playerKey else {
//                return .failure(.unknown)
//            }
//            switch await fetchPlayer(keyPlayer: playerKey) {
//            case .success(let playerImage):
//                decodeResponse[0].lineup.away.startingLineups[i].playerKey = playerImage.first?.imagePlayer
//            case .failure(_):
//                return .failure(.unknown)
//            }
//        }
        return .success(decodeResponse)
    }


    func fetchPlayer(keyPlayer: String) async -> Result<[RestPlayer], HTTPError> {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "apiv3.apifootball.com"
        urlComponents.path = "/"
        urlComponents.queryItems = [
            URLQueryItem(name: "action", value: "get_players"),
            URLQueryItem(name: "player_id", value: "\(keyPlayer)"),
            URLQueryItem(name: "APIkey", value: Key.apiKey)
        ]

        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        guard let (data, response) = try? await URLSession.shared.data(for: request, delegate: nil) else { return .failure(.unknown)
        }

        guard let response = response as? HTTPURLResponse else {
            return .failure(.noResponse)
        }

        guard (200...299).contains(response.statusCode) else {
            return .failure(.wrongStatusCode)
        }

        guard var decodeResponse = try? JSONDecoder().decode([RestPlayer].self, from: data) else {
            return .failure(.invalideData)
        }

        guard decodeResponse.count > 1 else {
            return .success(decodeResponse)
        }

        decodeResponse.removeSubrange(1..<decodeResponse.count)
        return .success(decodeResponse)
    }
}
