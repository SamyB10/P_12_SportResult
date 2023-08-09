//
//  Router.swift
//  Sport
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
import UIKit

protocol CompetitionRoutingLogic: AnyObject {
    func routeToNextPage(id: String)
}

final class CompetitionRouter {
    private weak var viewController: UIViewController?
    private var standingViewController: UIViewController?
    
    func inject(viewController: UIViewController) {
        self.viewController = viewController
    }

    func injectStandingViewController(viewController: UIViewController) {
        self.standingViewController = viewController
    }
}

extension CompetitionRouter: CompetitionRoutingLogic {
    func routeToNextPage(id: String) {
        guard let standingViewController = standingViewController as? StandingViewController else { return }
        self.viewController?.navigationController?.pushViewController(standingViewController, animated: true)
        standingViewController.inject(leagueId: id)
    }
}
