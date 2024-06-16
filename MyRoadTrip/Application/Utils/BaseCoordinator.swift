//
//  BaseCoordinator.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 12/06/24.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    func start()
}

class BaseCoordinator {
    let navigation: UINavigationController

    init(nav: UINavigationController) {
        self.navigation = nav
    }
}
