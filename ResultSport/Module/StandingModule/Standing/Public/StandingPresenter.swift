//
//  StandingPresentationLogic.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

public protocol StandingPresentationLogic: AnyObject {
    func presentInterface(with response: [StandingModels.Response])
    func presentLoader()
    func presentError(with error: Error)
}

public final class StandingPresenter {

    private weak var display: StandingDisplayLogic?
    private var interactor: StandingBusinessLogic
    private var viewModel: StandingModels.ViewModel?

    public init(interactor: StandingBusinessLogic) {
        self.interactor = interactor
    }

    func inject(display: StandingDisplayLogic) {
        self.display = display
    }

    private func mapResponse(with response: [StandingModels.Response]) -> [StandingModels.ViewModel] {
        response.compactMap { standing in
            return StandingModels.ViewModel(countryName: standing.countryName,
                                            leagueName: standing.leagueName,
                                            teamId: standing.teamId,
                                            teamName: standing.teamName,
                                            teamLogo: standing.teamLogo,
                                            promotion: standing.promotion,
                                            leaguePosition: standing.leaguePosition,
                                            leaguePlayed: standing.leaguePlayed,
                                            gameWin: standing.gameWin,
                                            gameNul: standing.gameNul,
                                            gameLose: standing.gameLose,
                                            standingPts: standing.standingPts)
        }

    }
}

extension StandingPresenter: StandingPresentationLogic {
    public func presentInterface(with response: [StandingModels.Response]) {
        let viewModel = mapResponse(with: response)
        display?.displayInterface(with: viewModel)
    }

    public func presentLoader() {
        display?.displayLoader()
    }

    public func presentError(with error: Error) {
        display?.displayError(with: error)
    }
}

extension StandingPresenter: StandingInteractionLogic {
    func didFetchLeague(leagueId: String) {
        Task {
            await interactor.start(leagueId: leagueId)
        }
    }
}
