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


    func fetchSchedule(from: String, to: String) async -> Result<[RestSchedule], HTTPError> {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "apiv3.apifootball.com"
        urlComponents.path = "/"
        urlComponents.queryItems = [
            URLQueryItem(name: "action", value: "get_events"),
            URLQueryItem(name: "from", value: from),
            URLQueryItem(name: "to", value: to),
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
}
