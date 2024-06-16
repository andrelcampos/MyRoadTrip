//
//  TripModel.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 11/06/24.
//

import Foundation

// MARK: - Trip Model
class TripModel {
    
    // MARK: Variables
    
    // User infos
    var origin: String
    var destination: String
    var dailyDistance: String

    // ChatGPT result
    var citiesToStep: [String] = []
    
    // Google General Route result
    var travelDetails: TravelDetails?
    
    // Google routes result
    var routes: [Int: RouteModel] = [:]
    
    /// Property with the CoreData reference
    var _tripEntity: TripEntity?
    
    // MARK: Initializers
    init(origin: String, destination: String, dailyDistance: String) {
        
        self.origin = origin
        self.destination = destination
        self.dailyDistance = dailyDistance
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

// MARK: - Travel Details Model
extension TripModel {
    struct TravelDetails {
        let distance: String
        let duration: String
    }
    
}

extension TripModel.TravelDetails {
    init(route: GoogleRoutesServices.Route) {
        distance = route.localizedValues.distance.text
        duration = route.localizedValues.staticDuration.text
    }
}

// MARK: - Route Model
struct RouteModel {
    
    let origin: String
    let destination: String
    let distance: String
    let duration: String
    let way: String
    let warnings: [String]
    let endLocation: LatLong?
    let steps: [StepModel]
}

extension RouteModel {
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

// MARK: - Step Model
struct StepModel {
    let distance: String
    let instruction: String?
}
