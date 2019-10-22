//
//  CategoryDataSource.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import CoreData

struct EmptyObject {}

protocol CategoryDataSourceProtocol {
    func saveCategory(_ category: Category, completion: @escaping (Result<EmptyObject, Error>) -> Void)
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void)
}

class CategoryDataSource: CategoryDataSourceProtocol {
    
    func saveCategory(_ category: Category, completion: @escaping (Result<EmptyObject, Error>) -> Void) {
        let context = CoreDataManager.shared.viewContext
        let moCategory = MOCategory(context: context)
        moCategory.name = category.name
        moCategory.color = category.color.encode()
        
        do {
            try context.save()
            completion(.success(EmptyObject()))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        let context = CoreDataManager.shared.viewContext
        let request: NSFetchRequest<MOCategory> = MOCategory.fetchRequest()
        
        do {
            let moCategories = try context.fetch(request)
            let categories = moCategories.compactMap { Category(moCategory: $0) }
            completion(.success(categories))
        } catch let error {
            completion(.failure(error))
        }
    }
    
}
