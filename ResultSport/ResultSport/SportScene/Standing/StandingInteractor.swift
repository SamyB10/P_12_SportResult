//
//  Interactor.swift
//  Sport
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation

class StandingInteractor {

    private weak var presenter: StandingPresenter?
    private var router: StandingRoutingLogic?
    private let request = HttpRequest()

    init(router: StandingRoutingLogic) {
        self.router = router
    }

    func inject(presenter: StandingPresenter) {
        self.presenter = presenter
    }
}

extension StandingInteractor: StandingBusinessLogic {

    func start() async {
        presenter?.presentError()
    }
    func fetch() async {}
}
