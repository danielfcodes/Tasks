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
    
    func createDefaultCategoriesIfNeeded() {
        let categoryDataSource = CategoryDataSource()
        categoryDataSource.getCategories { result in
            switch result {
            case .success(let categories):
                if categories.isEmpty {
                    self.createDefaultCategories()
                }
            default: return
            }
        }
    }
    
    private func createDefaultCategories() {
        let critical = Category(name: "Critical", color: "#FF0000")
        let high = Category(name: "High", color: "#ff791e")
        let normal = Category(name: "Normal", color: "#33d236")
        let low = Category(name: "Low", color: "#e2a0ff")
        
        let categoryDataSource = CategoryDataSource()
        categoryDataSource.saveCategories([critical, high, normal, low])
    }
    
}
