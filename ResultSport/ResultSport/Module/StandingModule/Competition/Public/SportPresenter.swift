//
//  File.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

public protocol SportPresentationLogic: AnyObject {
    func presentInterface(with response: [SportModels.Response])
    func presentLoader()
    func presentError()
}

public final class SportPresenter {
    
    private weak var display: SportDisplayLogic?
    private var interactor: SportBusinessLogic
    private var viewModel: SportModels.ViewModel?
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

    public init(interactor: SportBusinessLogic) {
        self.interactor = interactor
    }
    
    func inject(display: SportDisplayLogic) {
        self.display = display
    }

    private func mapResponseCompetitions(with response: [SportModels.Response]) -> [SportModels.ViewModel] {
        response.compactMap {
            return .init(countryName: $0.countryName,
                         leagueId: $0.leagueId,
                         leagueName: $0.leagueName,
                         leagueLogo: $0.leagueLogo,
                         countryLogo: $0.countryLogo,
                         countryId: $0.countryId)
        }
    }
}


extension SportPresenter: SportPresentationLogic {
    public func presentInterface(with response: [SportModels.Response]) {
        let viewModel = mapResponseCompetitions(with: response)
        if countryId?.count == 0 {
            viewModel.forEach {
                countryId?[$0.countryName] = $0.countryId
            }
        }
        display?.displayInterface(with: viewModel)
    }
    
    public func presentLoader() {}
    
    public func presentError() {
        display?.displayLoader()
    }
}

extension SportPresenter: SportInteractionLogic {
    func didLoad() {
        Task {
            await interactor.start()
        }
    }

    func didSelect(index: Int) {
        interactor.nextPage()
    }

    func searchCompetition(country: String) {
        self.country = country
    }
}
