//
//  TripEntity+CoreDataProperties.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//
//

import Foundation
import CoreData


extension TripEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripEntity> {
        return NSFetchRequest<TripEntity>(entityName: "TripEntity")
    }

    @NSManaged public var origin: String
    @NSManaged public var destination: String
    @NSManaged public var dailyDistance: String
    @NSManaged public var citiesToStep: [String]
    @NSManaged public var travelDetails: TravelDetailsEntity?
    @NSManaged public var routes: NSOrderedSet?

}

// MARK: Generated accessors for routes
extension TripEntity {

    @objc(insertObject:inRoutesAtIndex:)
    @NSManaged public func insertIntoRoutes(_ value: RouteEntity, at idx: Int)

    @objc(removeObjectFromRoutesAtIndex:)
    @NSManaged public func removeFromRoutes(at idx: Int)

    @objc(insertRoutes:atIndexes:)
    @NSManaged public func insertIntoRoutes(_ values: [RouteEntity], at indexes: NSIndexSet)

    @objc(removeRoutesAtIndexes:)
    @NSManaged public func removeFromRoutes(at indexes: NSIndexSet)

    @objc(replaceObjectInRoutesAtIndex:withObject:)
    @NSManaged public func replaceRoutes(at idx: Int, with value: RouteEntity)

    @objc(replaceRoutesAtIndexes:withRoutes:)
    @NSManaged public func replaceRoutes(at indexes: NSIndexSet, with values: [RouteEntity])

    @objc(addRoutesObject:)
    @NSManaged public func addToRoutes(_ value: RouteEntity)

    @objc(removeRoutesObject:)
    @NSManaged public func removeFromRoutes(_ value: RouteEntity)

    @objc(addRoutes:)
    @NSManaged public func addToRoutes(_ values: NSOrderedSet)

    @objc(removeRoutes:)
    @NSManaged public func removeFromRoutes(_ values: NSOrderedSet)

}

extension TripEntity : Identifiable {

}
