//
//  TaskDataSource.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation
import CoreData

protocol TaskDataSourceProtocol {
    func saveTask(_ task: Task, completion: @escaping (Result<EmptyObject, Error>) -> Void)
    func updateTask(moTask: MOTask, task: Task, completion: @escaping (Result<EmptyObject, Error>) -> Void)
    func getTasks(completion: @escaping (Result<[Task], Error>) -> Void)
    func getTask(withName name: String, completion: @escaping (Result<MOTask, Error>) -> Void)
    func setTaskToDone(withName name: String, completion: @escaping (Result<EmptyObject, Error>) -> Void)
}

class TaskDataSource: TaskDataSourceProtocol {
    
    private let categoryDataSource: CategoryDataSourceProtocol
    
    init(categoryDataSource: CategoryDataSourceProtocol = CategoryDataSource()) {
        self.categoryDataSource = categoryDataSource
    }
    
    func saveTask(_ task: Task, completion: @escaping (Result<EmptyObject, Error>) -> Void) {
        let context = CoreDataManager.shared.viewContext
        let moTask = MOTask(context: context)
        moTask.name = task.name
        moTask.expirationDate = Date()
        moTask.isDone = task.isDone
        
        categoryDataSource.getCategory(withName: task.category.name) { result in
            switch result {
            case .success(let moCategory):
                moTask.moCategory = moCategory
                
                do {
                    try context.save()
                    completion(.success(EmptyObject()))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func updateTask(moTask: MOTask, task: Task, completion: @escaping (Result<EmptyObject, Error>) -> Void) {
        let context = CoreDataManager.shared.viewContext

        moTask.name = task.name
        moTask.expirationDate = Date()
        moTask.isDone = task.isDone
        
        categoryDataSource.getCategory(withName: task.category.name) { result in
            switch result {
            case .success(let moCategory):
                moTask.moCategory = moCategory
                
                do {
                    try context.save()
                    completion(.success(EmptyObject()))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func getTasks(completion: @escaping (Result<[Task], Error>) -> Void) {
        let context = CoreDataManager.shared.viewContext
        let request: NSFetchRequest<MOTask> = MOTask.fetchRequest()
        
        do {
            let moTasks = try context.fetch(request)
            let tasks = moTasks.compactMap { Task(moTask: $0) }
            completion(.success(tasks))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func getTask(withName name: String, completion: @escaping (Result<MOTask, Error>) -> Void) {
        let context = CoreDataManager.shared.viewContext
        let predicate = NSPredicate(format: "name == %@", name)
        let request: NSFetchRequest<MOTask> = MOTask.fetchRequest()
        request.predicate = predicate

        do {
            guard let moTask = try context.fetch(request).first else {
                return
            }

            completion(.success(moTask))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func setTaskToDone(withName name: String, completion: @escaping (Result<EmptyObject, Error>) -> Void) {
        let context = CoreDataManager.shared.viewContext
        getTask(withName: name) { result in
            switch result {
            case .success(let moTask):
                moTask.isDone = true
                moTask.setToDone = Date()
                do {
                    try context.save()
                    completion(.success(EmptyObject()))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
}
