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
        return task.expirationDateString
    }
    
    var isDone: Bool {
        return task.isDone
    }
    
    var categoryColor: String {
        return task.category.color
    }
    
    var taskDidSetToDone: (() -> Void)?
    
    private let task: Task
    private let taskDataSource: TaskDataSourceProtocol
    
    init(task: Task, taskDataSource: TaskDataSourceProtocol = TaskDataSource()) {
        self.task = task
        self.taskDataSource = taskDataSource
    }
    
    func setTaskToDone() {
        task.isDone = true
        taskDataSource.setTaskToDone(withName: task.name) { result in
            switch result {
            case .success:
                self.taskDidSetToDone?()
            case .failure(let error): print("Error when setting to done \(error.localizedDescription)")
            }
        }
    }
    
}

/* TODO:
 - Cambiar el estilo del DONE BUTTON cuando este en DONE
 */
