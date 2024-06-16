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
    
    var goToStepByStep: (([StepModel]) -> Void)?
    var goToStartDriving: ((LatLong) -> Void)?
    var goToWhatToDo: ((LatLong) -> Void)?
    var goToWhereToStay: ((LatLong) -> Void)?
    
    lazy var titleStr: String           = { "Trecho \(stepIndex)" }()
    lazy var fromStr: String            = { "De \(route.origin)" }()
    lazy var toStr: String              = { "Até \(route.destination)" }()
    lazy var distanceStr: String        = { "Distância aproximada: \(route.distance)" }()
    
    lazy var stepByStepBtn: String      = { "Ver passo a passo" }()
    lazy var startDrivingBtn: String    = { "Dirigir para lá (Waze)" }()
    lazy var whatToDoBtn: String        = { "O que fazer em \(route.destination)?" }()
    lazy var whereToStayBtn: String     = { "Onde me hospedar" }()
    
    lazy var steps: [StepModel] = route.steps
    
    init(route: RouteModel, step: Int) {
        self.route = route
        self.stepIndex = step
    }
}
