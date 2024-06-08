//
//  GamePresenter.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

public protocol GamePresentationLogic: AnyObject {
    func presentInterface(with response: [GameModels.Response])
    func presentLoader()
    func presentError(with error: Error)
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

    private func day() {
        let calendar = Calendar.current
        let currentDate = Date()

        var dateComponents = DateComponents()
        dateComponents.day = -3
        guard let startDate = calendar.date(byAdding: dateComponents, to: currentDate) else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

        for day in weekdays {
            guard let dayIndex = weekdays.firstIndex(of: day) else { return }
            if let dateForDay = calendar.date(byAdding: .day, value: dayIndex, to: startDate) {
                var isActive = false
                if calendar.isDate(dateForDay, inSameDayAs: currentDate) {
                    isActive = true
                }

                let dayIndex = calendar.component(.weekday, from: dateForDay) - 1
                let day = weekdays[dayIndex]

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
        var viewModelLeague = GameModels.ViewModel.League()

        response.forEach { gameResponse in
            guard let gameViewModel = gameResponse.viewModel else { return }

            switch gameViewModel.leagueId {
            case League.englishLeague.rawValue:
                viewModelLeague.englishLeague.append(gameViewModel)
            case League.frenchLeague.rawValue:
                viewModelLeague.frenchLeague.append(gameViewModel)
            case League.spanishLeague.rawValue:
                viewModelLeague.spanishLeague.append(gameViewModel)
            case League.italyLeague.rawValue:
                viewModelLeague.italyLeague.append(gameViewModel)
            case League.germanyLeague.rawValue:
                viewModelLeague.germanyLeague.append(gameViewModel)
            case League.championsLeague.rawValue:
                viewModelLeague.championsLeague.append(gameViewModel)
            case League.europaLeague.rawValue:
                viewModelLeague.europaLeague.append(gameViewModel)
            default:
                viewModelLeague.word.append(gameViewModel)
            }
        }
        return GameModels.ViewModel.Championship(spanishLeague: viewModelLeague.spanishLeague,
                                                 frenchLeague: viewModelLeague.frenchLeague,
                                                 englishLeague: viewModelLeague.englishLeague,
                                                 italyLeague: viewModelLeague.italyLeague,
                                                 germanyLeague: viewModelLeague.germanyLeague,
                                                 word: viewModelLeague.word,
                                                 championsLeague: viewModelLeague.championsLeague,
                                                 europaLeague: viewModelLeague.europaLeague)
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
        case League.championsLeague.rawValue:
            display?.updateInterfaceGame(with: viewModel.championsLeague)
        case League.europaLeague.rawValue:
            display?.updateInterfaceGame(with: viewModel.europaLeague)
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

    public func presentLoader() {
        display?.displayLoader()
    }

    public func presentError(with error: Error) {
        display?.displayError(with: error)
    }
}

extension GamePresenter: GameInteractionLogic {

    func didLoad() {
        day()
    }

    func fetchGame(from: String, to: String, withLive: Bool) {
        switch withLive {
        case false:
            Task {
                await interactor.start(from: from, to: to, withLive: withLive)
            }
        case true :
            Task {
                await interactor.start(from: from, to: to, withLive: withLive)
            }
        }
    }

    func didSelectItem(indexPath: Int) {
        selectItem(indexPath: indexPath)
    }

    func didSelectLeague(id: String) {
        selectLeague(id: id)
    }

    func didSelectStatusGame(index: Int) {
        guard let date = viewModels.first(where: { $0.isActive == true }) else { return }
        switch index {
        case 0:
            fetchGame(from: date.dayNumber, to: date.dayNumber, withLive: false)
        case 1:
            fetchGame(from: date.dayNumber, to: date.dayNumber, withLive: true)
        default:
            break
        }
    }

    func didSelectGame(gameId: String) {
        interactor.nextPage(gameId: gameId)
    }

}
