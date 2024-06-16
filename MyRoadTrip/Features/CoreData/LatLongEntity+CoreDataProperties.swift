//
//  LatLongEntity+CoreDataProperties.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//
//

import Foundation
import CoreData


extension LatLongEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LatLongEntity> {
        return NSFetchRequest<LatLongEntity>(entityName: "LatLongEntity")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var route: RouteEntity?

}

extension LatLongEntity : Identifiable {

}
