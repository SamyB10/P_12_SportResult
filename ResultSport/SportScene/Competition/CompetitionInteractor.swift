//
//  CompetitionInteractor.swift
//  Sport
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
public enum NetworkError: Error {
    case failedLoading
}

class CompetitionInteractor {

    private weak var presenter: CompetitionPresentationLogic?
    private var router: CompetitionRoutingLogic?
    private let request = HttpRequest()
    
    init(router: CompetitionRoutingLogic) {
        self.router = router
    }
    
    func inject(presenter: CompetitionPresentationLogic) {
        self.presenter = presenter
    }
    
    private var contextSport = CompetitionContext() {
        didSet {
            guard contextSport != oldValue else { return }
            switch (contextSport.competitionContext, contextSport.didFailLoading) {
            case (_, true):
                let error = NetworkError.failedLoading
                self.presenter?.presentError(with: error)
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
            contextSport.competitionContext = competitions
        case .failure:
            contextSport.didFailLoading = true
        }
    }

    private func fetchCompetions() async {
        contextSport.willLoadContent()
        switch await request.fetchCountryAndLeague() {
        case .success(let competitions):
            contextSport.competitionContext = competitions
        case .failure:
            contextSport.didFailLoading = true
        }
    }

    private func presenteResponseCompetitions(with competitions: [RestCompetitions]) {
        let response = mapCompetitons(with: competitions)
        presenter?.presentInterface(with: response)
    }

    private func mapCompetitons(with competitions: [RestCompetitions]) -> [CompetitionModels.Response] {
        return competitions.compactMap { competition in
            guard let countryId = competition.countryId,
                  let name = competition.countryName,
                  let leagueId = competition.leagueId,
                  let leagueName = competition.leagueName,
                  let leagueSeason = competition.leagueSeason,
                  let leagueLogo = competition.leagueLogo,
                  let countryLogo = competition.countryLogo else { return nil }
            
            return CompetitionModels.Response(countryId: countryId,
                                        countryName: name,
                                        leagueId: leagueId,
                                        leagueName: leagueName,
                                        leagueSeason: leagueSeason,
                                        leagueLogo: leagueLogo,
                                        countryLogo: countryLogo)
        }
    }
}

extension CompetitionInteractor: CompetitionBusinessLogic {
    func start() async {
        await fetchCompetions()
    }

    func fetchCountry(id: String) async {
        await fetchCompetionsWithId(id: id)
    }

    func nextPage(id: String) {
        router?.routeToNextPage(id: id)
    }
}
