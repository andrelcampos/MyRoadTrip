//
//  LegDetailsViewModel.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

import Foundation

// MARK: - Class

class LegDetailsViewModel {
    
    let route: RouteModel
    let stepIndex: Int
    
    var goToStepByStep: ((RouteModel) -> Void)?
    var goToStartDriving: LocationVoid?
    var goToWhatToDo: LocationVoid?
    var goToWhereToStay: LocationVoid?
    
    lazy var titleStr: String           = { "Trecho \(stepIndex)" }()
    lazy var fromStr: String            = { "De:" }()
    lazy var toStr: String              = { "Até:" }()
    lazy var distanceStr: String        = { "Distância aproximada:" }()
    
    lazy var stepByStepBtn: String      = { "Ver passo a passo" }()
    lazy var startDrivingBtn: String    = { "Dirigir para lá (Waze)" }()
    lazy var whatToDoBtn: String        = { "O que fazer em \(route.destination)?" }()
    lazy var whereToStayBtn: String     = { "Onde me hospedar" }()
    
    lazy var steps: [StepModel] = route.steps
    
    init(route: RouteModel, step: Int) {
        self.route = route
        self.stepIndex = step
    }
    
    func goToStepsTapped() {
        goToStepByStep?(route)
    }
    
    func goToStartDrivingTapped() {
        guard let location = route.endLocation else { return }
        goToStartDriving?(location)
    }
    
    func goToWhatToDoTapped() {
        guard let location = route.endLocation else { return }
        goToWhatToDo?(location)
    }

    func goToWhereToStayTapped() {
        guard let location = route.endLocation else { return }
        goToWhereToStay?(location)
    }
}
