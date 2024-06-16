//
//  TripDetailsCoordinator.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 12/06/24.
//

import Foundation
import UIKit

class TripDetailsCoordinator: BaseCoordinator {
    
    let trip: TripModel
    
    init(nav: UINavigationController, trip: TripModel) {
        self.trip = trip
        super.init(nav: nav)
    }
    
    func start() {
        DispatchQueue.main.async {
            
            let vm = TripDetailsViewModel(trip: self.trip)
            let controller = TripDetailsViewController(viewModel: vm)
            controller.hidesBottomBarWhenPushed = true
            self.navigation.pushViewController(controller, animated: true)
        }
    }
}
