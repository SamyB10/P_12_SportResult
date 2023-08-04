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

    init(interactor: Interactor,
         presenter: SportPresenter,
         router: Router) {

        self.viewController = SportModuleKit.createViewController(presenter: presenter)
        interactor.inject(presenter: presenter)
        router.inject(viewController: viewController)
    }
}
