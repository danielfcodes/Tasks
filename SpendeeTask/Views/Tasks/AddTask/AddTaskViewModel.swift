//
//  AddTaskViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

class AddTaskViewModel {
    
    var category: Category? {
        didSet {
            categoryDidUpdate?()
        }
    }
    
    var taskSaved: (() -> Void)?
    var categoryDidUpdate: (() -> Void)?
    
    private let taskDataSource: TaskDataSourceProtocol
    
    init(taskDataSource: TaskDataSourceProtocol = TaskDataSource()) {
        self.taskDataSource = taskDataSource
    }
    
    func setCategory(_ category: Category) {
        self.category = category
    }
    
    func saveTask(name: String, expirationDate: String) {
        guard category != nil else { return }
        let task = Task(name: name, expirationDate: expirationDate, isDone: false, category: category!)
        taskDataSource.saveTask(task) { result in
            switch result {
            case .success: self.taskSaved?()
            case .failure(let error): print("Error while saving task \(error.localizedDescription)")
            }
        }
    }
    
}
