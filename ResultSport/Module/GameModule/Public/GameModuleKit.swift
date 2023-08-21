//
//  GameModuleKit.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import UIKit

public struct GameModuleKit {

    public static func createViewController(presenter: GamePresenter) -> UIViewController {

        let viewController = GameViewController()

        viewController.inject(presenter: presenter)
        presenter.inject(display: viewController)
        return viewController
    }
}
