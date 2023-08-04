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
                         countryLogo: $0.countryLogo)
        }
    }
}


extension SportPresenter: SportPresentationLogic {
    public func presentInterface(with response: [SportModels.Response]) {
        let viewModel = mapResponseCompetitions(with: response)
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
}
