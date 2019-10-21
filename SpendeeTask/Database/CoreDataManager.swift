//
//  CoreDataManager.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    var persistentContainer: NSPersistentContainer = {
        let pc = NSPersistentContainer(name: "Spendee")
        pc.loadPersistentStores { storeDescription, error in
            if let error = error {
                // TODO: Handle error
                fatalError()
            }
        }
        
        return pc
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveMainContext() {
        guard viewContext.hasChanges else { return }
        
        do {
            try viewContext.save()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
}
