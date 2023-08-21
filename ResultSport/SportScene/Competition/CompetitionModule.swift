//
//  CompetitionModule.swift
//
//  Created by Samy Boussair on 26/07/2023.
//

import UIKit

final class CompetitionModule {
    
    var viewController: UIViewController

    init(interactor: CompetitionInteractor,
         presenter: CompetitionPresenter,
         router: CompetitionRouter) {

        self.viewController = CompetitionModuleKit.createViewController(presenter: presenter)
        interactor.inject(presenter: presenter)
        router.inject(viewController: viewController)
    }
}
