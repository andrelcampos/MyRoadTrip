//
//  StepByStepCoordinator.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

import UIKit

class StepByStepCoordinator: BaseCoordinator {
    
    let route: RouteModel
    
    init(nav: UINavigationController, route: RouteModel) {
        self.route = route
        super.init(nav: nav)
    }
    
    func start() {
        DispatchQueue.main.async {
            let vm = StepByStepViewModel(route: self.route)
            let vc = StepByStepViewController(viewModel: vm)
            self.navigation.pushViewController(vc, animated: true)
        }
    }
}
