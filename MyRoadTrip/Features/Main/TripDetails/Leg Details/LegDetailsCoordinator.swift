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
        if UIApplication.shared.canOpenURL(URL(string: "https://waze.com/ul")!) {
            // Waze is installed. Launch Waze and start navigation
            let urlStr = String(format: "https://waze.com/ul?ll=%f,%f&navigate=yes", location.latitude, location.longitude)
            UIApplication.shared.open(URL(string: urlStr)!)
        }
    }
    
    private func goToWhatToDo(location: LatLong) {
        GooglePlacesServices.getPlacesAround(location) { response in
            // CALL PLACES VIEW CONTROLLER
        }
    }
    
    private func goToWhereToStay(location: LatLong) {
        //www.google.com/maps/search/Hotéis/@-29.9113182,-51.1799296,11
        guard let url = URL(string: "www.google.com/maps/search/Hoteis/@\(location.latitude),\(location.longitude),11z") else { return }
        
        UIApplication.shared.open(url)
    }
}
