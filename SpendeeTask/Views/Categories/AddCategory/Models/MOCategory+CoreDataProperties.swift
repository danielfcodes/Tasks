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

    @NSManaged public var color: NSObject?
    @NSManaged public var name: String?

}
