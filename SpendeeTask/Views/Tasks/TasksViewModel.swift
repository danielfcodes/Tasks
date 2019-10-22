//
//  TasksViewModel.swift
//  SpendeeTask
//
//  Created by Daniel Gustavo Fernandez Yopla on 22/10/2019.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

class TasksViewModel {
    
    var tasks: [Task] = []
    var tasksDidLoad: (() -> Void)?
    
    private let taskDataSource: TaskDataSourceProtocol
    
    init(taskDataSource: TaskDataSourceProtocol = TaskDataSource()) {
        self.taskDataSource = taskDataSource
    }
    
    func getTasks() {
        tasks.removeAll()
        taskDataSource.getTasks { result in
            switch result {
            case .success(let tasks):
                self.tasks = tasks
                self.tasksDidLoad?()
            case .failure(let error): print("Error when fetching tasks \(error.localizedDescription)")
            }
        }
    }
    
    func getViewModel(at indexPath: IndexPath) -> TaskCellViewModel {
        return TaskCellViewModel(task: tasks[indexPath.row])
    }
    
}
