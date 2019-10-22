//
//  MOCategory+CoreDataProperties.swift
//  
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//
//

import Foundation
import CoreData

extension MOCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOCategory> {
        return NSFetchRequest<MOCategory>(entityName: "MOCategory")
    }

    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var moTask: NSSet?

}

// MARK: Generated accessors for moTask
extension MOCategory {

    @objc(addMoTaskObject:)
    @NSManaged public func addToMoTask(_ value: MOTask)

    @objc(removeMoTaskObject:)
    @NSManaged public func removeFromMoTask(_ value: MOTask)

    @objc(addMoTask:)
    @NSManaged public func addToMoTask(_ values: NSSet)

    @objc(removeMoTask:)
    @NSManaged public func removeFromMoTask(_ values: NSSet)

}
