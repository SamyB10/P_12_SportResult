//
//  GameModule.swift
//
//  Created by Samy Boussair on 26/07/2023.
//

import UIKit

final class GameModule {
    
    var viewController: UIViewController
    
    init(interactor: GameInteractor,
         presenter: GamePresenter,
         router: GameRouter) {

        self.viewController = GameModuleKit.createViewController(presenter: presenter)
        interactor.inject(presenter: presenter)
        router.inject(viewController: viewController)
    }
}
