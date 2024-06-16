//
//  PlacesListViewModel.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

import Foundation

class PlacesListViewModel {
    
    let type: PlaceType
    let places: [Place]
    let city: String
    
    var goToWebsite: StringVoid?
    var goToGoogleDetails: StringVoid?
    var goToStartDriving: LocationVoid?
    
    lazy var titleStr = {
        switch type {
        case .attraction:
            return "O que fazer em \(city)?"
        case .hotel:
            return "Onde ficar em \(city)?"
        }
    }()
    
    lazy var navTitleStr = {
        switch type {
        case .attraction:
            return "Atrações"
        case .hotel:
            return "Hotéis"
        }
    }()
    
    init(type: PlaceType, places: [Place], city: String) {
        self.type = type
        self.places = places
        self.city = city
    }
}

