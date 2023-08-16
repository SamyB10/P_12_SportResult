//
//  SportModule.swift
//  Sport
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
import UIKit

final class StandingModule {
    
    var viewController: UIViewController
    
    init(interactor: StandingInteractor,
         presenter: StandingPresenter,
         router: StandingRouter) {

        self.viewController = StandingModuleKit.createViewController(presenter: presenter)
        interactor.inject(presenter: presenter)
        router.inject(viewController: viewController)
    }
}
