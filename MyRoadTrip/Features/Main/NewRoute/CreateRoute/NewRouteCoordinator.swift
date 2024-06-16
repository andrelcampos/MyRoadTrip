//
//  NewRouteCoordinator.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 12/06/24.
//

import Foundation
import UIKit

class NewRouteCoordinator {
    
    let controller: NewRouteViewController
    
    init(controller: NewRouteViewController) {
        self.controller = controller
        
        controller.viewModel.goToTripDetails = { trip in
            DispatchQueue.main.async {
                let nav = controller.navigationController ?? UINavigationController()
                TripDetailsCoordinator(nav: nav, trip: trip).start()
            }
        }
    }
}
