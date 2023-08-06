//
//  File.swift
//  
//
//  Created by Samy Boussair on 26/07/2023.
//

import Foundation
import UIKit

public protocol SportBusinessLogic {
    func start() async
    func fetch() async
    func nextPage()
    func fetchCountry(id: String) async
}
