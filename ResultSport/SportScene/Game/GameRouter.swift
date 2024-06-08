//
//  GameRouter.swift
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
import UIKit

protocol GameRoutingLogic: AnyObject {
    func routeToNextPage(gameId: String)
}

final class GameRouter {
    private weak var viewController: UIViewController?
    private var gameDetailsViewController: UIViewController?

    func inject(viewController: UIViewController) {
        self.viewController = viewController
    }

    func injectGameDetailsViewController(viewController: UIViewController) {
        self.gameDetailsViewController = viewController
    }
}

extension GameRouter: GameRoutingLogic {
    func routeToNextPage(gameId: String) {
        guard let gameDetailsViewController = gameDetailsViewController as? GameDetailsViewController else { return }
        self.viewController?.navigationController?.pushViewController(gameDetailsViewController, animated: true)
        gameDetailsViewController.injectGameId(gameId: gameId)
    }
}
