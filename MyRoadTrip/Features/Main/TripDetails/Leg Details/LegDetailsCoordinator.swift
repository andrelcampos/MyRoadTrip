//
//  LegDetailsCoordinator.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

import Foundation
import UIKit

class LegDetailsCoordinator: BaseCoordinator {
    
    let route: RouteModel
    let stepNumber: Int
    
    init(nav: UINavigationController, route: RouteModel, stepNumber: Int) {
        self.route = route
        self.stepNumber = stepNumber
        super.init(nav: nav)
    }
    
    func start() {
        DispatchQueue.main.async {
            let vm = LegDetailsViewModel(route: self.route, step: self.stepNumber)
            vm.goToStepByStep = self.goToStepByStep
            vm.goToStartDriving = self.goToStartDriving
            vm.goToWhatToDo = self.goToWhatToDo
            vm.goToWhereToStay = self.goToWhereToStay
            
            let vc = LegDetailsViewController(viewModel: vm)
            self.navigation.pushViewController(vc, animated: true)
        }
    }
    
    private func goToStepByStep(_ steps: [StepModel]) {
        // CALL STEP BY STEP VIEW CONTROLLER
    }
    
    private func goToStartDriving(location: LatLong) {
        // CALL FUNCTION TO MAP APPS
    }
    
    private func goToWhatToDo(location: LatLong) {
        GooglePlacesServices.getPlacesAround(location) { response in
            // CALL PLACES VIEW CONTROLLER
        }
    }
    
    private func goToWhereToStay(location: LatLong) {
        // CALL TRIP ADVISOR SITE
    }
}
