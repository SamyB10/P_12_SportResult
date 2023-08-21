//
//  GameRouter.swift
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
import UIKit

protocol GameRoutingLogic: AnyObject {
    func routeToNextPage(viewController: UIViewController)
}

final class GameRouter {
    private weak var viewController: UIViewController?
    
    func inject(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension GameRouter: GameRoutingLogic {
    func routeToNextPage(viewController: UIViewController) {
        self.viewController = viewController
    }
}
