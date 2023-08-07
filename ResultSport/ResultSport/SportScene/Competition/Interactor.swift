//
//  Interactor.swift
//  Sport
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
//import SportModuleKit

class Interactor {

    private weak var presenter: SportPresenter?
    private var router: SportRoutingLogic?
    private let request = HttpRequest()
    
    init(router: SportRoutingLogic) {
        self.router = router
    }
    
    func inject(presenter: SportPresenter) {
        self.presenter = presenter
    }
    
    private var contextSport = SportContext() {
        didSet {
            guard contextSport != oldValue else { return }
            switch (contextSport.sportContext, contextSport.didFailLoading) {
            case (_, true):
                self.presenter?.presentError()
            case (.none, false):
                self.presenter?.presentLoader()
            case (.some(let competitionsContent), false):
                self.presenteResponseCompetitions(with: competitionsContent)
            }
        }
    }
    
    private func fetchCompetionsWithId(id: String) async {
        contextSport.willLoadContent()
        switch await request.fetchCountryAndLeague(id: id) {
        case .success(let competitions):
            contextSport.sportContext = competitions
        case .failure:
            contextSport.didFailLoading = true
        }
//        // MARK: Simulate response
//        let competitions = await simulateFetchingCompetitions()
//        presenteResponseCompetitions(with: competitions)
    }

    private func fetchCompetions() async {
        contextSport.willLoadContent()
        switch await request.fetchCountryAndLeague() {
        case .success(let competitions):
            contextSport.sportContext = competitions
        case .failure:
            contextSport.didFailLoading = true
        }
//        // MARK: Simulate response
//        let competitions = await simulateFetchingCompetitions()
//        presenteResponseCompetitions(with: competitions)
    }

    // MARK: Simulate response
    private func simulateFetchingCompetitions() async -> [RestCompetitions] {
        var competitions: [RestCompetitions] = []

        for i in 1...20 {
            let countryId = "\(i)"
            let countryName = "Pays \(i)"
            let leagueId = "\(i)"
            let leagueName = "Ligue \(i)"
            let leagueSeason = "2021"
            let leagueLogo = "logo\(i)"
            let countryLogo = "logo_pays\(i)"

            let competition = RestCompetitions(countryId: countryId, countryName: countryName, leagueId: leagueId, leagueName: leagueName, leagueSeason: leagueSeason, leagueLogo: leagueLogo, countryLogo: countryLogo)

            competitions.append(competition)
        }

        return competitions
    }

    private func presenteResponseCompetitions(with competitions: [RestCompetitions]) {
        let response = mapCompetitons(with: competitions)
        presenter?.presentInterface(with: response)
    }

    private func mapCompetitons(with competitions: [RestCompetitions]) -> [SportModels.Response] {
        return competitions.compactMap { competition in
            guard let countryId = competition.countryId,
                  let name = competition.countryName,
                  let leagueId = competition.leagueId,
                  let leagueName = competition.leagueName,
                  let leagueSeason = competition.leagueSeason,
                  let leagueLogo = competition.leagueLogo,
                  let countryLogo = competition.countryLogo else { return nil }
            
            return SportModels.Response(countryId: countryId,
                                        countryName: name,
                                        leagueId: leagueId,
                                        leagueName: leagueName,
                                        leagueSeason: leagueSeason,
                                        leagueLogo: leagueLogo,
                                        countryLogo: countryLogo)
        }
    }
}

extension Interactor: SportBusinessLogic {
    func start() async {
        await fetchCompetions()
    }

    func fetchCountry(id: String) async {
        await fetchCompetionsWithId(id: id)
    }
    
    func fetch() async {}

    func nextPage(id: String) {
        router?.routeToNextPage(id: id)
    }
}
