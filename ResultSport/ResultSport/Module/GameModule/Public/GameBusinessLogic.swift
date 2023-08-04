//
//  File 4.swift
//  
//
//  Created by Samy Boussair on 28/07/2023.
//

import Foundation
import UIKit

public protocol GameBusinessLogic {
    func start(from: String, to: String) async
    func fetch() async
}
