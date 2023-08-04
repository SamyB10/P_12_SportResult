//
//  File 3.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation

public protocol StandingPresentationLogic: AnyObject {
    func presentInterface(with response: [StandingModels.Response])
    func presentLoader()
    func presentError()
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
}

extension StandingPresenter: StandingPresentationLogic {
    public func presentInterface(with response: [StandingModels.Response]) {}

    public func presentLoader() {}

    public func presentError() {
        display?.displayLoader()
    }
}

extension StandingPresenter: StandingInteractionLogic {
    func didLoad() {
        Task {
            await interactor.start()
        }
    }
}
