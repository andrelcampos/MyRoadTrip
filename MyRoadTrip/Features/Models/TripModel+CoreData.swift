//
//  TripModel+CoreData.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 15/06/24.
//

import Foundation
import CoreData
import UIKit

// MARK: - Save data to CoreData
extension TripModel {
    
    func saveToCoreData() {
        let context = CoreDataStack.shared.context
        
        let tripEntity = TripEntity(context: context)
        tripEntity.origin = self.origin
        tripEntity.destination = self.destination
        tripEntity.dailyDistance = self.dailyDistance
        tripEntity.citiesToStep = self.citiesToStep
        
        if let travelDetails = self.travelDetails {
            let travelDetailsEntity = TravelDetailsEntity(context: context)
            travelDetailsEntity.distance = travelDetails.distance
            travelDetailsEntity.duration = travelDetails.duration
            tripEntity.travelDetails = travelDetailsEntity
        }
        
        for route in self.routes.values {
            let routeEntity = RouteEntity(context: context)
            routeEntity.origin = route.origin
            routeEntity.destination = route.destination
            routeEntity.distance = route.distance
            routeEntity.duration = route.duration
            routeEntity.way = route.way
            routeEntity.warnings = route.warnings
            if let endLocation = route.endLocation {
                let latLongEntity = LatLongEntity(context: context)
                latLongEntity.latitude = endLocation.latitude
                latLongEntity.longitude = endLocation.longitude
                routeEntity.endLocation = latLongEntity
            }
            for step in route.steps {
                let stepEntity = StepEntity(context: context)
                stepEntity.distance = step.distance
                stepEntity.instruction = step.instruction
                routeEntity.addToSteps(stepEntity)
            }
            tripEntity.addToRoutes(routeEntity)
        }
        
        _tripEntity = tripEntity
        
        do {
            try context.save()
            NotificationCenter.default.post(name: .newTripAdded, object: nil)
        } catch {
            print("Failed to save trip: \(error.localizedDescription)")
        }
    }
}

// MARK: - Get history from CoreData
extension TripModel {
    static func fetchAllTrips() -> [TripModel] {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<TripEntity> = TripEntity.fetchRequest()
        
        do {
            let tripEntities = try context.fetch(fetchRequest)
            var trips: [TripModel] = []
            
            for tripEntity in tripEntities {
                let trip = TripModel(origin: tripEntity.origin,
                                     destination: tripEntity.destination,
                                     dailyDistance: tripEntity.dailyDistance)
                trip.citiesToStep = tripEntity.citiesToStep
                
                if let travelDetailsEntity = tripEntity.travelDetails {
                    trip.travelDetails = TravelDetails(distance: travelDetailsEntity.distance, 
                                                       duration: travelDetailsEntity.duration)
                }
                if let routeEntities = tripEntity.routes?.array as? [RouteEntity] {
                    for routeEntity in routeEntities {
                        var steps: [StepModel] = []
                        if let stepEntities = routeEntity.steps?.array as? [StepEntity] {
                            for stepEntity in stepEntities {
                                let step = StepModel(distance: stepEntity.distance, 
                                                     instruction: stepEntity.instruction)
                                steps.append(step)
                            }
                        }
                        
                        var endLocation: LatLong? = nil
                        if let endlocationEntity = routeEntity.endLocation {
                            endLocation = LatLong(latitude: endlocationEntity.latitude,
                                                  longitude: endlocationEntity.longitude)
                        }
                        
                        let route = RouteModel(origin: routeEntity.origin,
                                               destination: routeEntity.destination,
                                               distance: routeEntity.distance,
                                               duration: routeEntity.duration,
                                               way: routeEntity.way,
                                               warnings: routeEntity.warnings,
                                               endLocation: endLocation,
                                               steps: steps)
                        trip.routes[trip.routes.count] = route
                    }
                }
                trip._tripEntity = tripEntity
                trips.append(trip)
            }
            return trips
        } catch {
            print("Failed to fetch trips: \(error.localizedDescription)")
            return []
        }
    }
}

// MARK: - Delete methods
extension TripModel {
    
    @discardableResult func deleteFromCoreData() -> Bool {
        guard let trip = _tripEntity else { return false }
        let context = CoreDataStack.shared.context
        context.delete(trip)

        do {
            try context.save()
            return true
        } catch {
            print("Failed to delete trip: \(error)")
            return false
        }
    }
    
    @discardableResult static func deleteAllTrips() -> Bool {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TripEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            return true
        } catch {
            print("Failed to delete all trips: \(error)")
            return false
        }
    }
}
