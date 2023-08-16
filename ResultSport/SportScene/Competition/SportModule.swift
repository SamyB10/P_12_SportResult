//
//  SportModule.swift
//  Sport
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
import UIKit
//import SportModuleKit

final class SportModule {
    
    var viewController: UIViewController

    init(interactor: CompetitionInteractor,
         presenter: CompetitionPresenter,
         router: CompetitionRouter) {

        self.viewController = CompetitionModuleKit.createViewController(presenter: presenter)
        interactor.inject(presenter: presenter)
        router.inject(viewController: viewController)
    }
}
