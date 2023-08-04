//
//  File.swift
//  
//
//  Created by Samy Boussair on 01/08/2023.
//

import Foundation
import UIKit

extension UINavigationController {

    public func setupNavBarColor() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear

        let titleFont = UIFont.systemFont(ofSize: 25)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                          NSAttributedString.Key.font: titleFont]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.tintColor = .white

        UIBarButtonItem.appearance().tintColor = .white
    }
}
