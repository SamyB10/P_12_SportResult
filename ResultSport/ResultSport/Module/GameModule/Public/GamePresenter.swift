//
//  File 3.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

public protocol GamePresentationLogic: AnyObject {
    func presentInterface(with response: [GameModels.Response])
    func presentLoader()
    func presentError()
}

enum League: String {
    case englishLeague = "152"
    case frenchLeague = "168"
    case italyLeague = "207"
    case germanyLeague = "175"
    case spanishLeague = "302"
}

public final class GamePresenter {

    private weak var display: GameDisplayLogic?
    private var interactor: GameBusinessLogic
    private var viewModels: [GameModels.ViewModel] = []

    public init(interactor: GameBusinessLogic) {
        self.interactor = interactor
    }

    func inject(display: GameDisplayLogic) {
        self.display = display
    }

    func day() {
        let calendar = Calendar.current
        let currentDate = Date()

        var dateComponents = DateComponents()
        dateComponents.day = -3
        let startDate = calendar.date(byAdding: dateComponents, to: currentDate)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

        for i in 0..<7 {
            if let dateForDay = calendar.date(byAdding: .day, value: i, to: startDate) {
                var isActive = false
                if calendar.isDate(dateForDay, inSameDayAs: currentDate) {
                    isActive = true
                }
                let day = weekdays[i]
                let dateString = dateFormatter.string(from: dateForDay)
                let viewModel = GameModels.ViewModel(day: day,
                                                     dayNumber: dateString,
                                                     isActive: isActive)
                viewModels.append(viewModel)
            }
        }
        display?.displayInterface(with: viewModels)
    }

    private func deSelectItem() {
        viewModels.indices.forEach { index in
            if viewModels[index].isActive {
                let currentItemSelected = GameModels.ViewModel(day: viewModels[index].day,
                                                               dayNumber: viewModels[index].dayNumber,
                                                               isActive: false)
                viewModels[index] = currentItemSelected
            }
        }
    }

    private func selectItem(indexPath: Int) {
        deSelectItem()
        let item = viewModels[indexPath]
        let nextItemSelected = GameModels.ViewModel(day: item.day,
                                                    dayNumber: item.dayNumber,
                                                    isActive: true)
        viewModels[indexPath] = nextItemSelected
        display?.displayInterface(with: viewModels)
    }

//    private func mapResponseGame(with response: [GameModels.Response]) -> [GameModels.ViewModel.Game] {
//        return response.compactMap { gameResponse in
//            guard let countryName = gameResponse.countryName,
//                  let leagueId = gameResponse.leagueId,
//                  let leagueName = gameResponse.leagueName,
//                  let matchStatus = gameResponse.matchStatus,
//                  let matchTime = gameResponse.matchTime,
//                  let homeTeamName = gameResponse.homeTeamName,
//                  let homeTeamScore = gameResponse.homeTeamScore,
//                  let awayTeamName = gameResponse.awayTeamName,
//                  let awayTeamScore = gameResponse.awayTeamScore,
//                  let stadium = gameResponse.stadium,
//                  let homeBadge = gameResponse.homeBadge,
//                  let awayBadge = gameResponse.awayBadge,
//                  let leagueLogo = gameResponse.leagueLogo else { return nil }
//
//            return GameModels.ViewModel.Game(countryName: countryName,
//                                             leagueId: leagueId,
//                                             leagueName: leagueName,
//                                             matchStatus: matchStatus,
//                                             matchTime: matchTime,
//                                             homeTeamName: homeTeamName,
//                                             homeTeamScore: homeTeamScore,
//                                             awayTeamName: awayTeamName,
//                                             awayTeamScore: awayTeamScore,
//                                             stadium: stadium,
//                                             homeBadge: homeBadge,
//                                             awayBadge: awayBadge,
//                                             leagueLogo: leagueLogo)
//        }
//    }

    private func mapResponseGameTest(with response: [GameModels.Response]) -> GameModels.ViewModel.Championship {
        var englishLeague: [GameModels.ViewModel.Game] = []
        var frenchLeague: [GameModels.ViewModel.Game] = []
        var spanishLeague: [GameModels.ViewModel.Game] = []
        var italyLeague: [GameModels.ViewModel.Game] = []
        var germanyLeague: [GameModels.ViewModel.Game] = []
        var word: [GameModels.ViewModel.Game] = []

        response.forEach { gameResponse in
            guard let gameViewModel = gameResponse.viewModel else { return }

            switch gameViewModel.leagueId {
            case League.englishLeague.rawValue:
                englishLeague.append(gameViewModel)
            case League.frenchLeague.rawValue:
                frenchLeague.append(gameViewModel)
            case League.spanishLeague.rawValue:
                spanishLeague.append(gameViewModel)
            case League.italyLeague.rawValue:
                italyLeague.append(gameViewModel)
            case League.germanyLeague.rawValue:
                germanyLeague.append(gameViewModel)
            default:
                word.append(gameViewModel)
            }
        }
        return GameModels.ViewModel.Championship(spanishLeague: spanishLeague,
                                                 frenchLeague: frenchLeague,
                                                 englishLeague: englishLeague,
                                                 italyLeague: italyLeague,
                                                 germany: germanyLeague,
                                                 word: word)
    }
}


extension GamePresenter: GamePresentationLogic {
    public func presentInterface(with response: [GameModels.Response]) {
        let viewModel = mapResponseGameTest(with: response)
        display?.displayInterfaceGame(with: viewModel)
    }

    public func presentLoader() {}

    public func presentError() {
        display?.displayLoader()
    }
}

extension GamePresenter: GameInteractionLogic {

    func didLoad() {
        day()
    }

    func fetchGame(from: String, to: String) {
        Task {
            await interactor.start(from: from, to: to)
        }
    }

    func didSelectItem(indexPath: Int) {
        selectItem(indexPath: indexPath)
    }
}
