//
//  MOTask+CoreDataProperties.swift
//  
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//
//

import Foundation
import CoreData

extension MOTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOTask> {
        return NSFetchRequest<MOTask>(entityName: "MOTask")
    }

    @NSManaged public var name: String?
    @NSManaged public var expirationDate: Date?
    @NSManaged public var setToDone: Date?
    @NSManaged public var isDone: Bool
    @NSManaged public var moCategory: MOCategory?

}
