//
//  File 2.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import UIKit

public struct StandingModuleKit {

    public static func createViewController(presenter: StandingPresenter) -> UIViewController {

        let viewController = StandingViewController()

        viewController.inject(presenter: presenter)
        presenter.inject(display: viewController)
        return viewController
    }
}
