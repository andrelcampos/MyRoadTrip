//
//  StepEntity+CoreDataProperties.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//
//

import Foundation
import CoreData


extension StepEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StepEntity> {
        return NSFetchRequest<StepEntity>(entityName: "StepEntity")
    }

    @NSManaged public var distance: String
    @NSManaged public var instruction: String?
    @NSManaged public var route: RouteEntity?

}

extension StepEntity : Identifiable {

}
