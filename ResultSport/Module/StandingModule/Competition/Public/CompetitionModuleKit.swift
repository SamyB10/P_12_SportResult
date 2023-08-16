import UIKit

public struct CompetitionModuleKit {

    public static func createViewController(presenter: CompetitionPresenter) -> UIViewController {
        
        let viewController = CompetitionViewController()

        viewController.inject(presenter: presenter)
        presenter.inject(display: viewController)
        return viewController
    }
}
