//
//  TaskCellViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

class TaskCellViewModel {
    
    var name: String {
        return task.name
    }
    
    var expirationDate: String {
        return task.expirationDate
    }
    
    var isDone: Bool {
        return task.isDone
    }
    
    var categoryColor: String {
        return task.category.color
    }
    
    private let task: Task
    
    init(task: Task) {
        self.task = task
    }
    
}
