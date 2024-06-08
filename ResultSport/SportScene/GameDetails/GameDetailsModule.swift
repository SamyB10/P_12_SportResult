//
//  StandingModule.swift
//
//  Created by Samy Boussair on 26/07/2023.
//

import UIKit

final class GameDetailsModule {
    
    var viewController: UIViewController
    
    init(interactor: GameDetailsInteractor,
         presenter: GameDetailsPresenter,
         router: GameDetailsRouter) {

        self.viewController = GameDetailsModuleKit.createViewController(presenter: presenter)
        interactor.inject(presenter: presenter)
        router.inject(viewController: viewController)
    }
}
