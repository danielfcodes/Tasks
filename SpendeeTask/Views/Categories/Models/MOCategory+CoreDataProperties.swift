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
    @NSManaged public var moTask: MOTask?

}
