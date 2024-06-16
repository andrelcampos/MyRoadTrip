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
    
    private func goToStepByStep(to route: RouteModel) {
        StepByStepCoordinator(nav: navigation, route: route).start()
    }
    
    private func goToStartDriving(location: LatLong) {
        CommomMethods.openWaze(with: location)
    }
    
    private func goToWhatToDo(location: LatLong) {
        GooglePlacesServices.getAttractionsAround(location) { response in
            guard let model = response?.places else { return }
            PlacesListCoordinator(nav: self.navigation,
                                  places: model,
                                  ofType: .attraction,
                                  in: self.route.destination).start()
        }
    }
    
    private func goToWhereToStay(location: LatLong) {
        GooglePlacesServices.getHotelsAround(location) { response in
            guard let model = response?.places else { return }
            PlacesListCoordinator(nav: self.navigation,
                                  places: model,
                                  ofType: .hotel,
                                  in: self.route.destination).start()
        }
    }
}
