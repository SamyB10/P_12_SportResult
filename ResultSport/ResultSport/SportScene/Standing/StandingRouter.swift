//
//  Router.swift
//  Sport
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
import UIKit

protocol StandingRoutingLogic: AnyObject {
    func routeToNextPage(viewController: UIViewController)
}

final class StandingRouter {
    private weak var viewController: UIViewController?
    
    func inject(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension StandingRouter: StandingRoutingLogic {
    func routeToNextPage(viewController: UIViewController) {
        self.viewController = viewController
    }
}
