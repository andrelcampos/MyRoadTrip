//
//  PlacesListCoordinator.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

import Foundation
import UIKit

class PlacesListCoordinator: BaseCoordinator {
    
    let places: [Place]
    let type: PlaceType
    let city: String
    
    init(nav: UINavigationController, places: [Place], ofType type: PlaceType, in city: String) {
        self.places = places
        self.type = type
        self.city = city
        super.init(nav: nav)
    }
    
    func start() {
        DispatchQueue.main.async {
            let vm = PlacesListViewModel(type: self.type, places: self.places, city: self.city)
            vm.goToGoogleDetails = self.goToSite(url:)
            vm.goToWebsite = self.goToSite(url:)
            vm.goToStartDriving = CommomMethods.openWaze(with:)
            let vc = PlacesListViewController(viewModel: vm)
            self.navigation.pushViewController(vc, animated: true)
        }
    }
    
    func goToSite(url urlStr: String) {
        DispatchQueue.main.async {
            if let url = URL(string: urlStr),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
