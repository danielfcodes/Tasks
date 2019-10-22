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
- Keyboards se van con tap
 - pasar el getMO Model al data source en lugar de hacer un get en el view model
 - Poner en la main queue todos los bindings que actualicen vista
 - DateFormatter para las celdas
 - TaskItem dentro de TASKS folder
 - Cambiar el estilo del DONE BUTTON cuando este en DONE
 - Un label informativo en el detalle
 */
