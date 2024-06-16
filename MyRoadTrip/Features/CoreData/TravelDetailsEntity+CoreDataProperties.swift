//
//  TravelDetailsEntity+CoreDataProperties.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//
//

import Foundation
import CoreData


extension TravelDetailsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TravelDetailsEntity> {
        return NSFetchRequest<TravelDetailsEntity>(entityName: "TravelDetailsEntity")
    }

    @NSManaged public var duration: String
    @NSManaged public var distance: String
    @NSManaged public var trip: TripEntity?

}

extension TravelDetailsEntity : Identifiable {

}
