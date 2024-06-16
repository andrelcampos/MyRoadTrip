//
//  RouteEntity+CoreDataProperties.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//
//

import Foundation
import CoreData


extension RouteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RouteEntity> {
        return NSFetchRequest<RouteEntity>(entityName: "RouteEntity")
    }

    @NSManaged public var origin: String
    @NSManaged public var destination: String
    @NSManaged public var duration: String
    @NSManaged public var way: String
    @NSManaged public var distance: String
    @NSManaged public var warnings: [String]
    @NSManaged public var endLocation: LatLongEntity?
    @NSManaged public var trip: TripEntity?
    @NSManaged public var steps: NSOrderedSet?

}

// MARK: Generated accessors for steps
extension RouteEntity {

    @objc(insertObject:inStepsAtIndex:)
    @NSManaged public func insertIntoSteps(_ value: StepEntity, at idx: Int)

    @objc(removeObjectFromStepsAtIndex:)
    @NSManaged public func removeFromSteps(at idx: Int)

    @objc(insertSteps:atIndexes:)
    @NSManaged public func insertIntoSteps(_ values: [StepEntity], at indexes: NSIndexSet)

    @objc(removeStepsAtIndexes:)
    @NSManaged public func removeFromSteps(at indexes: NSIndexSet)

    @objc(replaceObjectInStepsAtIndex:withObject:)
    @NSManaged public func replaceSteps(at idx: Int, with value: StepEntity)

    @objc(replaceStepsAtIndexes:withSteps:)
    @NSManaged public func replaceSteps(at indexes: NSIndexSet, with values: [StepEntity])

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: StepEntity)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: StepEntity)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSOrderedSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSOrderedSet)

}

extension RouteEntity : Identifiable {

}
