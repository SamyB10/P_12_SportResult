//
//  Interactor.swift
//  Sport
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

class StandingInteractor {

    private weak var presenter: StandingPresentationLogic?
    private var router: StandingRoutingLogic?
    private let request = HttpRequest()

    private var contextStanding = StandingContext() {
        didSet {
            guard contextStanding != oldValue else { return }
            switch (contextStanding.standingContext, contextStanding.didFailLoading) {
            case (_, true):
                let error = NetworkError.failedLoading
                self.presenter?.presentError(with: error)
            case (.none, false):
                self.presenter?.presentLoader()
            case (.some(let standingContent), false):
                self.presenteResponse(with: standingContent)
            }
        }
    }

    init(router: StandingRoutingLogic) {
        self.router = router
    }

    func inject(presenter: StandingPresentationLogic) {
        self.presenter = presenter
    }

    private func fetchStanding(leagueId: String) async {
        contextStanding.willLoadContent()
        switch await request.fetchStanding(leagueId: leagueId) {
        case .success(let standing):
            contextStanding.standingContext = standing
        case .failure:
            contextStanding.didFailLoading = true
        }
    }

    private func presenteResponse(with standing: [RestStanding]) {
        let response = mapStanding(with: standing)
        presenter?.presentInterface(with: response)
    }

    private func mapStanding(with standing: [RestStanding]) -> [StandingModels.Response] {
        return standing.compactMap { standing in
            return StandingModels.Response(countryName: standing.countryName,
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

extension StandingInteractor: StandingBusinessLogic {
    func start(leagueId: String) async {
        await fetchStanding(leagueId: leagueId)
    }
}
