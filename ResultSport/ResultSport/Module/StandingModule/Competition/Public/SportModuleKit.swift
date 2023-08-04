import UIKit

public struct SportModuleKit {

    public static func createViewController(presenter: SportPresenter) -> UIViewController {
        
        let viewController = CompetitionViewController()

        viewController.inject(presenter: presenter)
        presenter.inject(display: viewController)
        return viewController
    }
}
