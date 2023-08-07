//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import UIKit

class StandingViewController: UIViewController {

    private var presenter: StandingInteractionLogic?
    private var idLeague: String? {
        didSet {
            guard let idLeague, idLeague != oldValue else { return }
            presenter?.didFetchLeague(leagueId: idLeague)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainColorTest
        setupInterface()
        setupConstraints()
    }

    func inject(leagueId: String) {
        self.idLeague = leagueId
    }

    private func setupInterface() {

    }

    private func setupConstraints() {
    }
    
    func inject(presenter: StandingInteractionLogic) {
        self.presenter = presenter
    }
}

extension StandingViewController: StandingDisplayLogic {
    func displayInterface(with viewModel: [StandingModels.ViewModel]) {
        print(viewModel)
    }

    func updateInterface(with viewModel: [StandingModels.ViewModel]) {}

    func displayError(with error: Error) {}

    func displayLoader() {}
}
