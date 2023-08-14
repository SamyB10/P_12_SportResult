//
//  File.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

public protocol CompetitionPresentationLogic: AnyObject {
    func presentInterface(with response: [CompetitionModels.Response])
    func presentLoader()
    func presentError(with error: Error)
}

public final class CompetitionPresenter {
    
    private weak var display: CompetitionDisplayLogic?
    private var interactor: CompetitionBusinessLogic
    private var viewModel: CompetitionModels.ViewModel?
    private var countryId: [String : String]? = [:] {
        didSet {
            guard let countryId, countryId != oldValue else { return }
            }
        }
    private var country: String? {
        didSet {
            guard let country, country != oldValue else { return }
            countryId?.forEach({ countryName in
                guard countryName.key == country else { return }
                Task {
                    await interactor.fetchCountry(id: countryName.value)
                }
            })
        }
    }

    public init(interactor: CompetitionBusinessLogic) {
        self.interactor = interactor
    }
    
    func inject(display: CompetitionDisplayLogic) {
        self.display = display
    }

    private func mapResponseCompetitions(with response: [CompetitionModels.Response]) -> [CompetitionModels.ViewModel] {
        response.compactMap {
            return CompetitionModels.ViewModel(countryName: $0.countryName,
                                               leagueId: $0.leagueId,
                                               leagueName: $0.leagueName,
                                               leagueLogo: $0.leagueLogo,
                                               countryLogo: $0.countryLogo,
                                               countryId: $0.countryId)
        }
    }
}


extension CompetitionPresenter: CompetitionPresentationLogic {
    public func presentInterface(with response: [CompetitionModels.Response]) {
        let viewModel = mapResponseCompetitions(with: response)
        if countryId?.count == 0 {
            viewModel.forEach {
                countryId?[$0.countryName] = $0.countryId
            }
        }
        display?.displayInterface(with: viewModel)
    }
    
    public func presentLoader() {
        display?.displayLoader()
    }
    
    public func presentError(with error: Error) {
        display?.displayError(with: error)
    }
}

extension CompetitionPresenter: CompetitionInteractionLogic {
    func didLoad() {
        Task {
            await interactor.start()
        }
    }

    func didSelect(id: String) {
        interactor.nextPage(id: id)
    }

    func searchCompetition(country: String) {
        self.country = country
    }
}
