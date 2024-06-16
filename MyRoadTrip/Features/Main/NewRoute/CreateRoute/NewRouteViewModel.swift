//
//  NewRouteViewModel.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 11/06/24.
//

import Foundation

// MARK: - Class
class NewRouteViewModel {
    
    let strings = Texts()
    var goToTripDetails: ((TripModel) -> Void)?
    
    private let gptService = OpenAIServices()
    private let routeService = GoogleRoutesServices()
    
    func tappedSearch(origin: String?, destination: String?, dailyDistance: String?, returnError: @escaping (String?) -> Void) {
        guard let origin = origin else { returnError("Origem não pode ser vazio"); return }
        guard let destination = destination else { returnError("Destino não pode ser vazio"); return }
        guard let dailyDistance = dailyDistance else { returnError("Distância deve ser entre 100 e 1000 KMs"); return }
        
        // create TripModel with user data
        let trip = TripModel(origin: origin, destination: destination, dailyDistance: dailyDistance)
        
        // get list of cities to travel by
        gptService.getListOfStopableCitiesTo(origin: origin, destination: destination, dailyDistance: dailyDistance) { [weak self, routeService, returnError] list in
            guard let list = list else { returnError("Erro ao buscar lista de cidades"); return }
            
            // update TripModel with waypoints for the trip
            trip.configCities(cities: list)
            
            // get infos to general route
            routeService.getGeneralRoute(from: list) { [weak self, routeService, trip, returnError] route in
                guard let route = route else { returnError("Erro ao buscar dados gerais da rota"); return }
                
                // update TripModel with general route infos
                trip.configDetails(route: route)
                
                let dispatchGroup = DispatchGroup()
                let dispatchQueue = DispatchQueue(label: "calling-detailed-routes")
                let dispatchSemaphore = DispatchSemaphore(value: 0)

                var errorList: [String] = []
                dispatchQueue.async {
                    for i in 0 ..< (list.count - 1) {
                        dispatchGroup.enter()
                        let step = i+1
                        let from = list[i]
                        let to = list[i+1]
                        
                        routeService.getDetailedRoute(from: from, to: to) { [trip, step, from, to] detailedRoute in
                            guard let route = detailedRoute?.routes.first else {
                                errorList.append("Erro ao buscar dados do Trecho \(step)")
                                dispatchSemaphore.signal()
                                dispatchGroup.leave()
                                return
                            }
                            
                            trip.addRoute(step: step, response: route, from: from, to: to)
                            dispatchSemaphore.signal()
                            dispatchGroup.leave()
                        }
                        dispatchSemaphore.wait()
                    }
                }

                dispatchGroup.notify(queue: dispatchQueue) {
                    if errorList.isEmpty {
                        returnError(nil)
//                        trip.saveToCoreData()
                        self?.goToTripDetails?(trip)
                    }
                    else {
                        var strError = "Erros encontrados:"
                        for err in errorList {
                            strError.append("\n\(err)")
                        }
                        returnError(strError)
                    }
                }
            }
        }
    }
}

// MARK: - Texts
extension NewRouteViewModel {
    struct Texts {
        let navTitle = "Nova Rota"
        let origStr = "Origem:"
        let origHolder = "Digite a cidade de origem"
        let destStr = "Destino:"
        let destHolder = "Digite a cidade de destino"
        let distStr = "Distância para dirigir por dia/trecho:"
        let distDefault = "350"
        let bttTitle = "Buscar Viagem"
    }
}
