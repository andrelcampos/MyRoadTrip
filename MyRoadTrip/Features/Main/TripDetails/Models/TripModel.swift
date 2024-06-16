//
//  TripModel.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 11/06/24.
//

import Foundation

// MARK: - Class
class TripModel {
    
    // MARK: Variables
    
    // User infos
    var origin: String
    var destination: String
    var distance: String

    // ChatGPT result
    var citiesToStep: [String] = []
    
    // Google General Route result
    var travelDetails: TravelDetails?
    
    // Google routes result
    var routes: [Int: RouteModel] = [:]
    
    // MARK: Initializers
    init(origin: String, destination: String, distance: String) {
        
        self.origin = origin
        self.destination = destination
        self.distance = distance
    }
    
    // MARK: Methods
    func configCities(cities: [String]) {
        self.citiesToStep = cities
    }
    
    func configDetails(route: GoogleRoutesServices.Route) {
        self.travelDetails = TravelDetails(route: route)
    }
    
    func addRoute(step: Int, response: GoogleRoutesServices.DetailedRoute, from: String, to: String) {
        routes[step] = RouteModel(route: response, origin: from, destination: to)
    }
}

extension TripModel {
    struct TravelDetails {
        let distance: String
        let duration: String
        
        init(route: GoogleRoutesServices.Route) {
            distance = route.localizedValues.distance.text
            duration = route.localizedValues.staticDuration.text
        }
    }
}

class RouteModel {
    
    let origin: String
    let destination: String
    let distance: String
    let duration: String
    let way: String
    let warnings: [String]
    let endLocation: LatLong?
    let steps: [StepModel]
    
    init(route: GoogleRoutesServices.DetailedRoute, origin: String, destination: String) {
        self.origin = origin
        self.destination = destination
        self.distance = route.localizedValues.distance.text
        self.duration = route.localizedValues.staticDuration.text
        self.way = route.description
        self.warnings = route.warnings
        self.endLocation = route.legs.first?.endLocation.latLng
        var steps: [StepModel] = []
        let routeSteps = route.legs.first?.steps ?? []
        for step in routeSteps {
            steps.append(StepModel(distance: step.localizedValues.distance.text,
                                   instruction: step.navigationInstruction?.instructions))
        }
        self.steps = steps
    }
}

struct StepModel {
    let distance: String
    let instruction: String?
}
