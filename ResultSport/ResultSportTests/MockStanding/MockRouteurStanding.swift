//
//  MockRouteur.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 14/08/2023.
//

import Foundation
@testable import ResultSport
import UIKit

class MockRouterStanding: StandingRoutingLogic {
    var didNextpage = false
    func routeToNextPage(viewController: UIViewController) {
        didNextpage = true
    }
}
