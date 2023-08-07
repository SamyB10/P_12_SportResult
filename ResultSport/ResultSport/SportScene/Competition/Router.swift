//
//  Router.swift
//  Sport
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
import UIKit

protocol SportRoutingLogic: AnyObject {
    func routeToNextPage(viewController: UIViewController, id: String)
}

final class Router {
    private weak var viewController: UIViewController?
    
    func inject(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension Router: SportRoutingLogic {
    func routeToNextPage(viewController: UIViewController, id: String) {
        guard let standingViewController = viewController as? StandingViewController else { return }
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
        standingViewController.inject(leagueId: id)

    }
}
