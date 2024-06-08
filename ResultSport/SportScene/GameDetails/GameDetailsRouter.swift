//
//  StandingRouter.swift
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
import UIKit

protocol GameDetailsRoutingLogic: AnyObject {
    func routeToNextPage(viewController: UIViewController)
}

final class GameDetailsRouter {
    private weak var viewController: UIViewController?
    
    func inject(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension GameDetailsRouter: GameDetailsRoutingLogic {
    func routeToNextPage(viewController: UIViewController) {
        self.viewController = viewController
    }
}
