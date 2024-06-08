import UIKit

public struct GameDetailsModuleKit {

    public static func createViewController(presenter: GameDetailsPresenter) -> UIViewController {
        
        let viewController = GameDetailsViewController()

        viewController.inject(presenter: presenter)
        presenter.inject(display: viewController)
        return viewController
    }
}
