//
//  TabBarController.swift
//
//  Created by Samy Boussair on 28/07/2023.
//

//import SportModuleKit
import UIKit

class TabBarController: UITabBarController {

    var viewControllerSearch: UIViewController?
    var viewControllerCompetiton: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .mainColor
        tabBar.barTintColor = .mainColor
    }

    func setUpTabs() {
        guard let viewControllerSearch = viewControllerSearch,
              let viewControllerCompetiton = viewControllerCompetiton else { return }
        let competitionViewController = self.createNav(with: "Competition",
                                                       and: UIImage(systemName: "text.justify"),
                                                       viewController: viewControllerCompetiton)
        let searchViewController = self.createNav(with: "Game",
                                                  and: UIImage(systemName: "sportscourt"),
                                                  viewController: viewControllerSearch)
        self.setViewControllers([searchViewController, competitionViewController], animated: false)
    }

    private func createNav(with title: String,
                           and image: UIImage?,
                           viewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: viewController)
        nav.setupNavBarColor()
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image

        let selectedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        tabBar.tintColor = UIColor.white
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
