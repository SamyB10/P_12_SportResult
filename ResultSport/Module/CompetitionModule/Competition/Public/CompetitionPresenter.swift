//
//  CompetitionPresenter.swift
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

enum CountryError: String, Error {
    case containsNonLetters = "The character string contains numbers or special characters."
    case unknownCountry = "Unknown Country"
}

public final class CompetitionPresenter {
    
    private weak var display: CompetitionDisplayLogic?
    private var interactor: CompetitionBusinessLogic
    private var viewModel: CompetitionModels.ViewModel?
    private var countryId: [String : String]? = [:]

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

    private func checkArrayIngredients(text: String) -> CountryError? {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z]+$")
        let range = NSRange(location: 0, length: text.utf16.count)
        let isOnlyLetters = regex.firstMatch(in: text, options: [], range: range) != nil
        var unknownCountry = true

        guard text != "" else {
            didLoad()
            return nil
        }

        guard isOnlyLetters else {
            return .containsNonLetters
        }

        countryId?.forEach({ countryName in
            if countryName.key == text {
                searchCompetition(country: countryName.value)
                unknownCountry = false
            }
        })

        guard unknownCountry == false else {
            return .unknownCountry
        }
        return nil
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
    func textFieldGood(country: String) -> CountryError? {
        if let error = checkArrayIngredients(text: country) {
            return error
        }
        return nil
    }

    func didLoad() {
        Task {
            await interactor.start()
        }
    }

    func didSelect(id: String) {
        interactor.nextPage(id: id)
    }

    func searchCompetition(country: String) {
        Task {
            await interactor.fetchCountry(id: country)
        }
    }
}
