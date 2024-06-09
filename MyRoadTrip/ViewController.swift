//
//  ViewController.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 05/06/24.
//

import UIKit

class ViewController: UIViewController {

    enum ServiceToTest {
        case gpt, google, advisor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let testing: ServiceToTest = .google
        
        switch testing {
        case .gpt:
            OpenAIServices.makeChatGPTRequest { trip in
                guard let trip = trip else { return }
                print(trip)
            }
        case .google:
//            GoogleRoutesServices.getGeneralRoute(from: GoogleRoutesServices.listOfCities) { route in
//                guard let route = route else { return }
//                print(route)
//            }
//            GoogleRoutesServices.getDetailedRoute(from: GoogleRoutesServices.listOfCities[0],
//                                                  to: GoogleRoutesServices.listOfCities[1]) { detailedRoute in
//                guard 
//                    let route = detailedRoute,
//                    let location = route.routes.first?.legs.last?.endLocation.latLng
//                else { return }
//                print(route)
//            }
            let location = GoogleRoutesServices.LatLong(latitude: -31.7700224, longitude: -52.3313353)
            GooglePlacesServices.getPlacesAround(location) { places in
                guard let places = places else { return }
                print(places)
            }
        case .advisor:
            break
        }
    }
}

