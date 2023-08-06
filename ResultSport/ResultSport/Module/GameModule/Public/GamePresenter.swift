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

enum League: String, CaseIterable {
    case englishLeague = "152"
    case frenchLeague = "168"
    case italyLeague = "207"
    case germanyLeague = "175"
    case spanishLeague = "302"
    case championsLeague = "3"
    case europaLeague = "4"
}

public final class GamePresenter {

    private weak var display: GameDisplayLogic?
    private var interactor: GameBusinessLogic
    private var viewModels: [GameModels.ViewModel] = []
    private var viewModelsChampionship: GameModels.ViewModel.Championship?


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

    private func mapResponseGame(with response: [GameModels.Response]) -> GameModels.ViewModel.Championship {
        var englishLeague: [GameModels.ViewModel.Game] = []
        var frenchLeague: [GameModels.ViewModel.Game] = []
        var spanishLeague: [GameModels.ViewModel.Game] = []
        var italyLeague: [GameModels.ViewModel.Game] = []
        var germanyLeague: [GameModels.ViewModel.Game] = []
        var championsLeague: [GameModels.ViewModel.Game] = []
        var europaLeague: [GameModels.ViewModel.Game] = []
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
            case League.championsLeague.rawValue:
                championsLeague.append(gameViewModel)
            case League.europaLeague.rawValue:
                europaLeague.append(gameViewModel)
            default:
                word.append(gameViewModel)
            }
        }
        return GameModels.ViewModel.Championship(spanishLeague: spanishLeague,
                                                 frenchLeague: frenchLeague,
                                                 englishLeague: englishLeague,
                                                 italyLeague: italyLeague,
                                                 germanyLeague: germanyLeague,
                                                 word: word,
                                                 championsLeague: championsLeague,
                                                 europaLeague: europaLeague)
    }

    private func selectLeague(id: String) {
        guard let viewModel = viewModelsChampionship else { return }
        switch id {
        case League.englishLeague.rawValue:
            display?.updateInterfaceGame(with: viewModel.englishLeague)
        case League.frenchLeague.rawValue:
            display?.updateInterfaceGame(with: viewModel.frenchLeague)
        case League.spanishLeague.rawValue:
            display?.updateInterfaceGame(with: viewModel.spanishLeague)
        case League.italyLeague.rawValue:
            display?.updateInterfaceGame(with: viewModel.italyLeague)
        case League.germanyLeague.rawValue:
            display?.updateInterfaceGame(with: viewModel.germanyLeague)
        default:
            display?.updateInterfaceGame(with: viewModel.word)
        }
    }
}

extension GamePresenter: GamePresentationLogic {
    public func presentInterface(with response: [GameModels.Response]) {
        let viewModel = mapResponseGame(with: response)
        self.viewModelsChampionship = viewModel
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

    func didSelectLeague(id: String) {
        selectLeague(id: id)
    }
}
