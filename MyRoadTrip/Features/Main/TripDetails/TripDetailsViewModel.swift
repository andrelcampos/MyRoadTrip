//
//  TripDetailsViewModel.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 12/06/24.
//

import Foundation

// MARK: - Class
class TripDetailsViewModel {
    
    var goToRouteDetails: (((RouteModel, Int)) -> Void)?
    
    let trip: TripModel
    
    lazy var headerTitle: String = {
        "Sua viagem \nde \(trip.origin) \npara \(trip.destination)"
    }()
    
    lazy var routes: [Int: RouteModel] = trip.routes
    
    init(trip: TripModel) {
        self.trip = trip
    }
}
