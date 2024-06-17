//
//  HistoryViewModel.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

import Foundation
import UIKit

class HistoryViewModel {
    
    var trips: [TripModel] = []
    
    func fetchTrips() {
        trips = TripModel.fetchAllTrips()
    }
    
    func openTrip(_ index: IndexPath, nav: UINavigationController) {
        TripDetailsCoordinator(nav: nav, trip: trips[index.row]).start()
    }
}
