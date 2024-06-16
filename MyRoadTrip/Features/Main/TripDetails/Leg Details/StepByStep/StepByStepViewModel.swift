//
//  StepByStepViewModel.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

class StepByStepViewModel {

    let route: RouteModel
    let steps: [StepModel]
    let navTitleStr = "Passo a passo"
    lazy var headerTitleStr = { "Saindo de \(route.origin) \n e indo até \(route.destination)" }()
    
    init(route: RouteModel) {
        self.route = route
        self.steps = route.steps
    }
}
